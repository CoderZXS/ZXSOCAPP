//
//  ENSDateHelper.h
//  11
//
//  Created by enesoon on 2020/4/1.
//  Copyright © 2020 enesoon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE    60
#define D_HOUR      3600
#define D_DAY       86400
#define D_WEEK      604800
#define D_YEAR      31556926

NS_ASSUME_NONNULL_BEGIN

@interface ENSDateHelper : NSObject

+ (instancetype)shareHelper;

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)milliSecond;

+ (NSString *)formattedTimeFromTimeInterval:(long long)timeInterval;

+ (NSString *)formattedTime:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
