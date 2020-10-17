//
//  IMPackReader.m
//  CGDDemo
//
//  Created by MoShen on 2017/8/1.
//  Copyright © 2017年 MoShen-Mike. All rights reserved.
//

#import "IMPackReader.h"
#import "IMDataTypeUtiltiy.h"
#import "IMPacket.h"


@interface IMPackReader()

{
    void* _isOnReadQueue;
    void* _isOnListenQueue;
}


/**读取输入的串行队列*/
@property(nonatomic,strong)dispatch_queue_t readQueue;

/**通知消息回调串行队列*/
@property(nonatomic,strong)dispatch_queue_t listenQueue;


/**接受到的包数据*/
@property(nonatomic,strong)NSMutableData* packetData;

/**接受到的消息数据*/
@property(nonatomic,strong)NSMutableArray* msgArray;

/**所有监听器*/
@property(nonatomic,strong)NSMutableSet<id<IMPacketListener>>* listenerArray;



@end


@implementation IMPackReader



-(NSMutableArray *)msgArray{
    
    __block NSMutableArray* msgArray = nil;
    dispatch_block_t block = ^(){
        if (!_msgArray) {
            _msgArray = [NSMutableArray arrayWithCapacity:MAX_MSG_COUNT];
        }
        msgArray = _msgArray;
    };
    
    if (dispatch_get_specific(_isOnReadQueue)){
        block();
    }else{
        dispatch_sync(self.readQueue, block);
    }
    return msgArray;
}





-(NSMutableSet<id<IMPacketListener>>*)listenerArray{

    __block NSMutableSet* listenerArray = nil;
    dispatch_block_t block = ^(){
        if (!_listenerArray) {
            _listenerArray = [NSMutableSet set];
        }
        listenerArray = _listenerArray;
    };

    if (dispatch_get_specific(_isOnListenQueue)){
        block();
    }else{
        dispatch_sync(self.listenQueue, block);
    }

    return listenerArray;
}



-(dispatch_queue_t)readQueue{
    if (!_readQueue) {
        _readQueue = dispatch_queue_create([@"com.ms.read.queue" UTF8String], DISPATCH_QUEUE_SERIAL);
        _isOnReadQueue = &_readQueue;
        void* nonNullUnusedPointer = (__bridge void*)self;
        dispatch_queue_set_specific(_readQueue, _isOnReadQueue, nonNullUnusedPointer, NULL);
    }
    return _readQueue;
}


-(dispatch_queue_t)listenQueue{
    
    if (!_listenQueue) {
        _listenQueue = dispatch_queue_create([@"com.ms.listener.queue" UTF8String], DISPATCH_QUEUE_SERIAL);
        _isOnListenQueue = &_listenQueue;
        void* nonNullUnusedPointer = (__bridge void*)self;
        dispatch_queue_set_specific(_listenQueue, _isOnListenQueue, nonNullUnusedPointer, NULL);
    }
    return _listenQueue;
}




-(NSMutableData *)packetData{
    if (!_packetData) {
        _packetData = [NSMutableData data];
    }
    return _packetData;
}


+ (instancetype)defaultReader{
    
    static IMPackReader* shareInstance = nil;
    static dispatch_once_t onceQueue;
    dispatch_once(&onceQueue, ^{
        shareInstance = [IMPackReader new];
    });
    return shareInstance;
}




/**解析TCP 输入流*/
-(void)parseData:(NSData*)data{
    
    dispatch_async(self.readQueue, ^{
        //拼接到待处理数据中
        NSData* appendData = [data copy];
        [self.packetData appendData:appendData];
        if (appendData.length < BUF_RECV_SIZE && self.packetData.length >= 20) {
            while (1) {
                
                if(self.packetData.length < 20){ //解析后的剩余数据不足一个包协议头的长度不用解析了
                    break;
                }
                
                NSString* pid = [[NSString alloc] initWithData:[self.packetData subdataWithRange:NSMakeRange(0, 2)] encoding:NSUTF8StringEncoding];
                if ([pid isEqualToString:@"US"]){
                    //是协议头 认为是包的开头
//                    NSData *lengthData = [self.packetData subdataWithRange:NSMakeRange(18, 2)];
//                    int lenght = 0;
//                    [data getBytes:&lenght length:lengthData.length];
                    Byte* byteLength = (Byte*)[self.packetData subdataWithRange:NSMakeRange(18, 2)].bytes;
                    int lenght = [IMDataTypeUtiltiy byteToInt:byteLength];
                    NSInteger msgLength = lenght + 20; //整个包长度

                    if (self.packetData.length >= msgLength) {
                        //解析到一个包
                        [self addMsgData:[self.packetData subdataWithRange:NSMakeRange(0, msgLength)]];
                        [self.packetData replaceBytesInRange:NSMakeRange(0, msgLength) withBytes:NULL length:0];
                        if (self.packetData.length == 0) {
                            break;
                        }
                    }else{
                        //包长度不够
                        break;
                    }
                }else{
                    //不是协议头 不用解析
                    if (self.packetData.length > 0) {
                        self.packetData = nil;
                    }
                    break;
                }
            }
        }
    });
}




- (void)addOfflineMsgPackets:(NSArray<IMPacket*>*)packets completeBlock:(void(^)())completeBlock{
    //通知监听器
    NSMutableSet* packetDelegateSet = [self.listenerArray mutableCopy];
    [packetDelegateSet enumerateObjectsUsingBlock:^(id<IMPacketListener>  _Nonnull obj, BOOL * _Nonnull stop) {
        if (*stop == NO) {
            if (![obj respondsToSelector:@selector(receiveNetPacket:)]) {
                return;
            }
            if (![obj respondsToSelector:@selector(isSupportMsg:)]) {
                return;
            }
            DESLog(@"当前队列:%@  %@",[NSThread currentThread],obj);
            for (IMPacket* packet in packets) {
                if ([obj isSupportMsg:packet]) {
                    [obj receiveNetPacket:packet];
                }
            }
        }
    }];
    
    if (completeBlock) {
        completeBlock();
    }
}





- (void)addOfflineMsgPacket:(IMPacket*)packet{
    //通知监听器
    NSMutableSet* packetDelegateSet = [self.listenerArray mutableCopy];
    [packetDelegateSet enumerateObjectsUsingBlock:^(id<IMPacketListener>  _Nonnull obj, BOOL * _Nonnull stop) {
        if (*stop == NO) {
            if (![obj respondsToSelector:@selector(receiveNetPacket:)]) {
                return;
            }
            
            if (![obj respondsToSelector:@selector(isSupportMsg:)]) {
                return;
            }
            DESLog(@"当前队列:%@  %@",[NSThread currentThread],obj);
            if ([obj isSupportMsg:packet]) {
                [obj receiveNetPacket:packet];
            }
        }
    }];
}




/** 接受到新消息添加到消息数队列中去 */
-(void)addMsgData:(NSData*)data{
    //通知监听器
    [self.listenerArray enumerateObjectsUsingBlock:^(id<IMPacketListener>  _Nonnull obj, BOOL * _Nonnull stop) {
        if (*stop == NO) {
            if (![obj respondsToSelector:@selector(receiveNetPacket:)]) {
                return;
            }
            
            if (![obj respondsToSelector:@selector(isSupportMsg:)]) {
                return;
            }
            
            IMPacket* packet = [IMPacket parseWithData:data];
            if ([obj isSupportMsg:packet]) {
                [obj receiveNetPacket:packet];
            }
        }
    }];
}




/**添加消息监听*/
- (void)addListen:(id<IMPacketListener>)listener{
    dispatch_async(self.readQueue, ^{
         [self.listenerArray addObject:listener];
    });
}



/**
 清空旧数据
 */
- (void)clearData{
    if (dispatch_get_specific(_isOnReadQueue)) {
        self.packetData = nil;
    }else{
        dispatch_sync(self.readQueue, ^{
            self.packetData = nil;
        });
    }
}





@end
