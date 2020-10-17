//
//  IMPackWrite.m
//  CGDDemo
//
//  Created by MoShen on 2017/8/4.
//  Copyright © 2017年 MoShen-Mike. All rights reserved.
//

#import "IMPackWrite.h"
#import "IMPacket.h"
#import "IMConnectManager.h"
#import "IMPackReader.h"
#import "SZEventControlCentre.h"
#import "IMSDK.h"



@interface IMPackWrite()

/* 消息待发送池 */
@property(nonatomic,strong)NSMutableDictionary<NSString*,IMPacket*>* packPool;

/* 中间缓存池 */
@property(nonatomic,strong)NSMutableDictionary<NSString*,IMPacket*>* cachePool;

/* 消息队列 */
@property(nonatomic,strong)dispatch_queue_t transmissionQueue;

/* 回调队列 */
@property(nonatomic,strong)dispatch_queue_t receiveQueue;

/* 发送消息超时监听Timer */
@property(nonatomic,strong)dispatch_source_t writeListenTimer;


@end

@implementation IMPackWrite




+ (instancetype)defaultWrite{
    
    static IMPackWrite* shareInstance = nil;
    static dispatch_once_t onceQueue;
    dispatch_once(&onceQueue, ^{
        shareInstance = [IMPackWrite new];
        dispatch_resume(shareInstance.writeListenTimer);
        //加入读取流监听消息 
        [[IMPackReader defaultReader] addListen:shareInstance];
    });
    
    return shareInstance;
}



- (dispatch_source_t)writeListenTimer{
    if (!_writeListenTimer) { 
        dispatch_source_t writeListenTimer =  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,dispatch_get_global_queue(0, 0));
        dispatch_source_set_timer(writeListenTimer, dispatch_walltime(NULL, 0),NSEC_PER_SEC,0);
        dispatch_source_set_event_handler(writeListenTimer, ^{
            dispatch_async(self.transmissionQueue, ^{
                NSMutableSet* packTimeOutSet = [NSMutableSet set];
                for (IMPacket* pack in [self.packPool allValues]) {
                    if (pack.overtime == 0) {
                        if (![pack.repeatStraegy isNeedRepeat]){
                            //超过了重发次数 添加到待移除池中
                            [packTimeOutSet addObject:pack];
                        }else{
                            pack.overtime--; //这个时候 < 0 会自动触发 pack.overtime 找超时策略所有时间
                        } 
                    }else{
                        pack.overtime--;
                    }
                    
                    //如果socket断开 直接回调超时 (聊天消息,登录消息除外)
                    if(![IMConnectManager defaultManager].socket.isConnected){
                        if((pack.packHead.cmdID != CmdId_MesChat) && (pack.packHead.cmdID != CmdId_GroupChat)){
                            [packTimeOutSet addObject:pack];
                        }
                    }
                }
                
                
                //如果有发送超时的 告诉网络协调控制器 有消息发送失败事件
                for (IMPacket* packet in [self.packPool allValues]) {
                    if (packet.allowRepeat && packet.overtime == 0) {
                        [[SZEventControlCentre defaultCenter] sendEvent:SZContrlEventTypeMsgSendTimeout values:nil];
                        break;
                    }
                }
                

                for (IMPacket* pack in packTimeOutSet) {
                    //从已发送池中彻底清除不需要再重发的
                    if ([pack respondsToSelector:@selector(didOverTime:)]) {
                        //发送超时 发起超时回调
                        [pack didOverTime:pack];
                    }
                    
                    [self.packPool removeObjectForKey:pack.packId];
                }
                
                //已发送池中还剩的需要重试
                for (IMPacket* packet in [self.packPool allValues]) {
                    if (packet.overtime!=0 || !packet.allowRepeat) {  //重试时间没到 或者 不支持重试的忽略掉
                        continue;
                    }
                    if ([IMConnectManager defaultManager].socket.isConnected) {
                        
                        DESLog(@"发送的cmid:%@",packet.ackId);
                        [[IMConnectManager defaultManager].socket writeData:packet.data withTimeout:25 tag:packet.packHead.cmdID];
                    }else{
                        [self.packPool removeObjectForKey:packet.packId];
                        [self.cachePool setObject:packet forKey:packet.packId];
                    }
                }
            });

        });
        _writeListenTimer = writeListenTimer;
    }
    return _writeListenTimer;
}







-(NSMutableDictionary *)packPool{
    if (!_packPool) {
        _packPool = [NSMutableDictionary dictionary];
    }
    return _packPool;
}


-(NSMutableDictionary *)cachePool{
    if (!_cachePool) {
        _cachePool = [NSMutableDictionary dictionary];
    }
    return _cachePool;
}




-(dispatch_queue_t)transmissionQueue{
    
    if (!_transmissionQueue) {
        _transmissionQueue = dispatch_queue_create([@"com.ms.socket.write.queue" UTF8String], DISPATCH_QUEUE_SERIAL);
    }
    return _transmissionQueue;
}


-(dispatch_queue_t)receiveQueue{
    if (!_receiveQueue) {
        _receiveQueue = dispatch_queue_create([@"com.ms.socket.write.recive.queue" UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return _receiveQueue;
}





/**
 把需要发送的消息添加到发送队列

 @param packet 需要传送的消息
 */
- (void)addPacketWriteQueue:(IMPacket*)packet{
    dispatch_async(self.transmissionQueue, ^{
        
        if (!packet||!packet.packId) {
            return ;
        }
        
        if(![IMConnectManager defaultManager].socket.isConnected){
            
            if(packet.isCallbackWithNoNetwork){
                [packet didOverTime:packet];
            }else{
                [self.cachePool setObject:packet forKey:packet.packId];
            }
            
        }else{
            void(^sendMsgBlock)() = ^{
                [[IMConnectManager defaultManager].socket writeData:packet.data withTimeout:25 tag:packet.packHead.cmdID];
                [self.packPool setObject:packet forKey:packet.packId];
                
            };
            sendMsgBlock();
        }
    });
}




/**
 发送不需要重试的数据包
 @param packet 需要传送的数据包
 */
- (void)writePacketWithOutRetry:(IMPacket*)packet{
    dispatch_async(self.transmissionQueue, ^{
         [[IMConnectManager defaultManager].socket writeData:packet.data withTimeout:25 tag:packet.packHead.cmdID];
    });
}





/**
 开始传输所有的数据
 */
- (void)startWritepack{
    dispatch_async(self.transmissionQueue, ^{
        dispatch_resume(self.writeListenTimer);
    });
}



- (void)recoverCachePoolWritepack{
    dispatch_async(self.transmissionQueue, ^{
        
        DESLog(@"recoverCachePoolWritepack的SessionId:%@",[CmInfo shareInfo].sessionId);
        for (IMPacket* packet in [self.cachePool allValues]) {
            packet.packHead.sessionID = [CmInfo shareInfo].sessionId; //用新的session 替换
            [packet updataPackeData];  //更新包data数据
            [self addPacketWriteQueue:packet];
        }
        [self.cachePool removeAllObjects];
        
    });
}



/**
 从消息队列中移除某个包
 
 @param packet 需要移除的包
 */
- (void)removePacketFromWriteQueue:(NSString*)packId{
    dispatch_async(self.transmissionQueue, ^{
        IMPacket* packetInPool = [self.packPool objectForKey:packId];
        if (packetInPool) {
            [self.packPool removeObjectForKey:packetInPool];
        }
    });
}




/**
 清除所有队列中的发送数据包
 */
- (void)clearAllQueuePacket{
    dispatch_async(self.transmissionQueue, ^{
        [self.packPool removeAllObjects];
        [self.cachePool removeAllObjects];
    });
}





/**
 停止写数据
 */
- (void)stopWritepack{

    dispatch_async(self.transmissionQueue, ^{
        
        for (IMPacket* pack in [self.packPool allValues]) {
            //从已发送池中彻底清除不需要再重发的
            if ([pack respondsToSelector:@selector(didOverTime:)]) {
                if (pack.packHead.cmdID == CmdId_MesOfflinemsg || pack.packHead.cmdID == CmdId_CmLogin) { //离线和登录请求包直接回调失败
                    [pack didOverTime:pack];
                    [self.packPool removeObjectForKey:pack.packId];
                }else if(pack.packHead.cmdID == CmdId_MesChat || pack.packHead.cmdID == CmdId_GroupChat){
                    [self.cachePool setObject:pack forKey:pack.packId];
                }else{
                    [pack didOverTime:pack];
                    [self.packPool removeObjectForKey:pack.packId];
                }
            }
        }
        
        //移除所有的包
        [self.packPool removeAllObjects];
    });
}



#pragma make - IMPacketListener

-(void)receiveNetPacket:(IMPacket *)packet{
    dispatch_async(self.transmissionQueue, ^{
        NSString* packetId = packet.packId;
        IMPacket* packetInPool = [self.packPool objectForKey:packetId];
        if (packetInPool) {
            if ([packetInPool respondsToSelector:@selector(receiveReple:)]) {
                //异步回调 这样就不会阻塞 发送处理队列
                dispatch_async(self.receiveQueue, ^{
                     [packetInPool receiveReple:packet];
                });
            }
            [self.packPool removeObjectForKey:packetId];
        }
    });
}



/**是否响应某种类型消息的监听 */
- (BOOL)isSupportMsg:(IMPacket*)packet{
    return YES;
}




-(void)dealloc{
    dispatch_cancel(self.writeListenTimer);
    self.writeListenTimer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





@end
