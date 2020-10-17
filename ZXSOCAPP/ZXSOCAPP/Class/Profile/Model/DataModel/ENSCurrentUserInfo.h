//
//  ENSCurrentUserInfo.h
//  ocdemo
//
//  Created by enesoon on 2020/5/18.
//  Copyright © 2020 enesoon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ENSCurrentUserInfo : NSObject<NSCoding>

@property (nonatomic ,copy) NSString *myUserID; //当前用户ID

@property (nonatomic ,strong) NSNumber *sex; //性别

@property (nonatomic ,strong) NSNumber *age; //年龄

@property (nonatomic ,copy) NSString *birthDay; //生日

@property (nonatomic ,strong,getter=isVip) NSNumber *vip; //是否会员

@property (nonatomic ,strong,getter=isOnline) NSNumber *online;//是否在线

@property (nonatomic ,copy) NSString *lastLoginTime; //最后登录时间

@property (nonatomic, copy) NSString *nickName; //我的昵称

@property (nonatomic, copy) NSString *portrait;  //头像url

+ (instancetype)currentUser;

//保存个人信息
+ (void)saveUserInfo:(ENSCurrentUserInfo *)userInfo;

//获取个人信息
+ (ENSCurrentUserInfo *)currentUserInfo;


@end

NS_ASSUME_NONNULL_END
