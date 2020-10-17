//
//  MSPackReader.h
//  CGDDemo
//
//  Created by MoShen on 2017/8/1.
//  Copyright © 2017年 MoShen-Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMPacketListener.h"

@class IMListener;



//一次性读取数据的最大值
#define BUF_RECV_SIZE  1024*2

//读取到的消息保存的最大消息数
#define MAX_MSG_COUNT  20


@interface IMPackReader : NSObject




+ (instancetype)defaultReader;




/**
 解析TCP 输入流

 @param data data
 */
- (void)parseData:(NSData*)data;




/**
 离线解析包回流到读取流

 @param packet 离线数据包
 */
- (void)addOfflineMsgPacket:(IMPacket*)packet;


/**
 一组离线解析包回流到读取流
 
 @param packets 一组离线数据包
 */
- (void)addOfflineMsgPackets:(NSArray<IMPacket*>*)packets completeBlock:(void(^)())completeBlock;

/**
 添加消息监听

 @param listener 消息监听类
 */
- (void)addListen:(id<IMPacketListener>)listener;



/**
 清空旧数据
 */
- (void)clearData;



@end
