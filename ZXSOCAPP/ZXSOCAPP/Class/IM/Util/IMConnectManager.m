//
//  MSIMConnectManager.m
//  NumberEngine
//
//  Created by MoShen on 2017/7/31.
//  Copyright © 2017年 MoShen-Mike. All rights reserved.
//

#import "IMConnectManager.h"
#import "GCDAsyncSocket+HeartBeat.h"
#import "IMPackReader.h"
#import "DEConstants.h"
#import "SIMManager.h"
#import "SZEventControlCentre.h"

#define kConnectMaxNum   5
#define kSocketReadTimeOut 30


NSString* const  kSocketConnectSuccessNotification =  @"__im_socket_connect_success_notification__"; //服务器连接成功通知
NSString* const  kSocketConnectDidDisconnectNotification =  @"__im_socket_did_disconnect_notification__"; //服务器断开连接通知
NSString* const  kSocketConnectFaildNotification = @"__im_socket_connect_faild_notification__";   //服务器连接失败通知
NSString* const  kSocketConnectingNotification = @"__im_socket_connecting_notification__";        //服务器连接中通知
NSString* const  kSocketConnectReadTimeOutNotification = @"__im_socket_read_timeout_notification__";    //服务器读超时


@interface IMConnectManager()<GCDAsyncSocketDelegate>
/**
 
 */

@property(nonatomic,assign)NSInteger connectNum; //重连次数

@property(nonatomic,copy)CompleteBlock connectBlock; //链接block
@property(nonatomic,copy)CompleteBlock cutBlock; //断开block


@end


@implementation IMConnectManager

-(GCDAsyncSocket *)socket{
    if (!_socket) {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _socket;
}


+ (instancetype)defaultManager{
    static IMConnectManager* shareInstance;
    static dispatch_once_t onceQueue;
    dispatch_once(&onceQueue, ^{
        shareInstance = [IMConnectManager new];
        shareInstance.connectNum = 0; //每次调用连接服务方法 把重新连接设置为 0  该行为一般为用户主动调用如果连接失败管理器默认帮忙重连到最大次数直到连接成功否则回调连接失败
        shareInstance.delegate = [SIMManager sharedInstance];
    });
    return shareInstance;
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       


//socket连接服务器
-(void)socketConnectHost:(CompleteBlock)completeBlock{
    
    _connectStatus = SocketConnectStatusConnecting;
    self.connectBlock = completeBlock;
    self.socket.userData = nil;
    
    //发送链接中通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kSocketConnectingNotification object:nil];
    
    if (self.socket.isConnected) {
        DESLog(@"socket.isConnected == YES");
        //发送链接成功通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kSocketConnectSuccessNotification object:nil];
        if(self.connectBlock){
           self.connectBlock(nil);
           self.connectBlock = nil;
        }
    }else{
        
        DESLog(@"socket 发起连接 -------");
        [self.socket connectToHost:CMIP onPort:CMPort withTimeout:25 error:nil];
        [self.delegate connectStatus:SIM_NETWORK_STATUS_CONNECTING error:nil];
    }
}



//主动与IM服务器断开
-(void)cutOffSocket:(CompleteBlock)completeBlock{
    
    if (self.socket.isConnected || _connectStatus == SocketConnectStatusConnecting) {
        
        self.cutBlock = completeBlock;
        self.socket.userData = @(SocketOfflineByUsers);// 声明是由用户主动切断
        [self.socket disconnect];
        
    }else{
        
        _connectStatus = SocketConnectStatusFailed;
        if (completeBlock) {
            completeBlock(nil);
            self.cutBlock = nil;
        }
    }
}



#pragma make - GCDAsyncSocketDelegate

//连接成功
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    
    
    //[sock startTLS:nil]; // 开始SSL握手 (只放开这一句就可以开启SSL验证)
    
    _connectStatus = SocketConnectStatusSuccessed;
    
    DESLog(@"连接成功: Host:%@ Port：%d",host,port);
    //重置userData
    
    if (self.connectBlock) {
        self.connectBlock(nil);
        self.connectBlock = nil;
    }
    
    [self.delegate connectStatus:SIM_NETWORK_STATUS_CONNECTED error:nil];
    
    //发送链接成功通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kSocketConnectSuccessNotification object:nil];
    
    //等待读取数据
    [self.socket readDataWithTimeout:-1 buffer:nil bufferOffset:0 maxLength:BUF_RECV_SIZE tag:0];
}


//连接断开
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    
    DESLog(@"连接断开:%@   userData:%d  connected:%d",err,[sock.userData intValue],self.socket.isConnected);

    _connectStatus = SocketConnectStatusFailed;
    self.socket.userData = nil;
    
    //不要使用err 作为参数传递  会造成奔溃 具体为什么崩溃 应该是执行到这里的时候 err 会被释放 导致 数据出错
    NSInteger errorCode = err.code;
    if (errorCode == 8) {
        //链接失败
        [[NSNotificationCenter defaultCenter] postNotificationName:kSocketConnectFaildNotification object:nil];
    }else if (errorCode == 4){
        //发送读取超时通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kSocketConnectReadTimeOutNotification object:nil];
    }else{
        //发送链接断开通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kSocketConnectDidDisconnectNotification object:nil];
    }
    
    [self.socket stopHeartBeat]; //停止心跳
    
    if (err.code == 4) {
        [self.delegate connectStatus:SIM_NETWORK_STATUS_DISCONNECTED error:err];
    }else {
        [self.delegate connectStatus:SIM_NETWORK_STATUS_CONNECTFAILD error:err];
    }


    if(self.cutBlock){
        self.cutBlock(err);
        self.cutBlock = nil;
    }
    
    
}


//数据已经发送成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    DELog(@"数据发送成功Tag:%ld",tag);
}


//读取到了数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
     DELog(@"读取到了数据长度:%ld  tag:%ld",data.length,tag);
     [self.socket readDataWithTimeout:kSocketReadTimeOut buffer:nil bufferOffset:0 maxLength:BUF_RECV_SIZE tag:0];
     [[IMPackReader defaultReader] parseData:data];
}


//写数据超时
-(NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
{
    DESLog(@"写入超时");
    return 0;
}



//读数据超时
- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length{
    
    DESLog(@"读取超时");
    return 0;
}




@end
