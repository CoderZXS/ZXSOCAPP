//
//  MSIMConnectManager.h
//  NumberEngine
//
//  Created by MoShen on 2017/7/31.
//  Copyright © 2017年 MoShen-Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import "IMCallBack.h"



typedef enum {
    SocketOfflineByUsers = 0x14,  // 用户主动cut
    SocketOfflineByWifiCuts = 1,  //断网
    SocketOfflineByServers = 2    // 服务器掉线
}SocketOfflines;


typedef enum {
    SocketConnectStatusUnknown,     //默认状态
    SocketConnectStatusConnecting,  //链接中....
    SocketConnectStatusSuccessed,   //链接成功....
    SocketConnectStatusFailed,      //链接失败....
}SocketConnectStatus;



extern  NSString* const  kSocketConnectingNotification; //服务器连接中通知
extern  NSString* const  kSocketConnectSuccessNotification;   //服务器连接成功通知
extern  NSString* const  kSocketConnectFaildNotification;     //服务器连接失败通知
extern  NSString* const  kSocketConnectDidDisconnectNotification; //服务器断开连接通知
extern  NSString* const  kSocketConnectReadTimeOutNotification; //服务器断开连接通知




@protocol IMConnectManagerDelegate <NSObject>

@optional

/**
 连接状态
 */
-(void)connectStatus:(SIMConnectStatus)connectStatus error:(NSError *)error;


@end


@interface IMConnectManager : NSObject

@property (nonatomic,strong) GCDAsyncSocket* socket;

@property (nonatomic,readonly) SocketConnectStatus connectStatus;  //链接状态

+ (instancetype)defaultManager;


/**
 IMConnectManagerDelegate 协议代理
 */
@property(nonatomic,weak)id<IMConnectManagerDelegate> delegate;


/**
 socket连接服务器
 */
-(void)socketConnectHost:(CompleteBlock)completeBlock;



/**
 主动与IM服务器断开
 */
-(void)cutOffSocket:(CompleteBlock)completeBlock;








@end
