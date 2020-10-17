//
//  IMPackWrite.h
//  CGDDemo
//
//  Created by MoShen on 2017/8/4.
//  Copyright © 2017年 MoShen-Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMPacketListener.h"

@class IMPacket;



@interface IMPackWrite : NSObject<IMPacketListener>


+ (instancetype)defaultWrite;




/**
 把需要发送的消息添加到发送队列
 
 @param packet 需要传送的消息
 */
- (void)addPacketWriteQueue:(IMPacket*)packet;



/**
 发送不需要重试的数据包

 @param packet 需要传送的数据包
 */
- (void)writePacketWithOutRetry:(IMPacket*)packet;




/**
 从消息队列中移除某个包

 @param packId 需要移除的包ID
 */
- (void)removePacketFromWriteQueue:(NSString*)packId;

/**
 清除所有队列中的发送数据包
 */
- (void)clearAllQueuePacket;


/**
 开始传输所有的数据
 */
- (void)startWritepack;




/**
 重新登录恢复之前的数据包
 */
- (void)recoverCachePoolWritepack;




/**
 停止写数据
 */
- (void)stopWritepack;

@end
