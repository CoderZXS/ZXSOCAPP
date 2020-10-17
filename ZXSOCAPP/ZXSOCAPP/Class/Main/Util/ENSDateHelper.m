//
//  ENSDateHelper.m
//  11
//
//  Created by enesoon on 2020/4/1.
//  Copyright © 2020 enesoon. All rights reserved.
//

#import "ENSDateHelper.h"

#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)

#define CURRENT_CALENDAR [NSCalendar currentCalendar]

static ENSDateHelper *helper = nil;

@interface ENSDateHelper()

@property (nonatomic, strong) NSDateFormatter *dfYMD;
@property (nonatomic, strong) NSDateFormatter *dfHM;
@property (nonatomic, strong) NSDateFormatter *dfYMDHM;
@property (nonatomic, strong) NSDateFormatter *dfYesterdayHM;

@property (nonatomic, strong) NSDateFormatter *dfBeforeDawnHM;
@property (nonatomic, strong) NSDateFormatter *dfAAHM;
@property (nonatomic, strong) NSDateFormatter *dfPPHM;
@property (nonatomic, strong) NSDateFormatter *dfNightHM;

@end


@implementation ENSDateHelper

#pragma mark - system

- (instancetype)init {
    if (self = [super init]) {
        //
    }
    
    return self;
}

#pragma mark - privite

+ (instancetype)shareHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[ENSDateHelper alloc] init];
    });
    
    return helper;
}

- (NSDateFormatter *)dfYMD {
    if (_dfYMD == nil) {
        _dfYMD = [self getDateFormatterWithFormat:@"YYYY/MM/dd"];
    }
    
    return _dfYMD;
}

- (NSDateFormatter *)dfHM {
    if (_dfHM == nil) {
        _dfHM = [self getDateFormatterWithFormat:@"HH:mm"];
    }
    
    return _dfHM;
}

- (NSDateFormatter *)dfYMDHM {
    if (_dfYMDHM == nil) {
        _dfYMDHM = [self getDateFormatterWithFormat:@"yyyy/MM/dd HH:mm"];
    }
    
    return _dfYMDHM;
}

- (NSDateFormatter *)dfYesterdayHM {
    if (_dfYesterdayHM == nil) {
        _dfYesterdayHM = [self getDateFormatterWithFormat:@"昨天HH:mm"];
    }
    
    return _dfYesterdayHM;
}

- (NSDateFormatter *)dfBeforeDawnHM {
    if (_dfBeforeDawnHM == nil) {
        _dfBeforeDawnHM = [self getDateFormatterWithFormat:@"凌晨hh:mm"];
    }
    
    return _dfBeforeDawnHM;
}

- (NSDateFormatter *)dfAAHM {
    if (_dfAAHM == nil) {
        _dfAAHM = [self getDateFormatterWithFormat:@"上午hh:mm"];
    }
    
    return _dfAAHM;
}

- (NSDateFormatter *)dfPPHM {
    if (_dfPPHM == nil) {
        _dfPPHM = [self getDateFormatterWithFormat:@"下午hh:mm"];
    }
    
    return _dfPPHM;
}

- (NSDateFormatter *)dfNightHM {
    if (_dfNightHM == nil) {
        _dfNightHM = [self getDateFormatterWithFormat:@"晚上hh:mm"];
    }
    
    return _dfNightHM;
}

#pragma mark - custom

- (NSDateFormatter *)getDateFormatterWithFormat:(NSString *)aFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = aFormat;
    return dateFormatter;
}

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)milliSecond {
    double timeInterval = milliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(milliSecond > 140000000000) {
        timeInterval = milliSecond / 1000;
    }
    NSDate *ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return ret;
}

+ (NSString *)formattedTimeFromTimeInterval:(long long)timeInterval {
    NSDate *date = [ENSDateHelper dateWithTimeIntervalInMilliSecondSince1970:timeInterval];
    return [ENSDateHelper formattedTime:date];
}

+ (NSString *)formattedTime:(NSDate *)date {
    ENSDateHelper *helper = [ENSDateHelper shareHelper];
    
    NSString *dateNow = [helper.dfYMD stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8, 2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5, 2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0, 4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *aDate = [gregorian dateFromComponents:components];
    
    NSInteger hour = [ENSDateHelper hoursFromDate:date toDate:aDate];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //If hasAMPM==TURE, use 12-hour clock, otherwise use 24-hour clock
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) { //24-hour clock
        if (hour <= 24 && hour >= 0) {
            dateFormatter = helper.dfHM;
        } else if (hour < 0 && hour >= -24) {
            dateFormatter = helper.dfYesterdayHM;
        } else {
            dateFormatter = helper.dfYMDHM;
        }
        
    } else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = helper.dfBeforeDawnHM;
        } else if (hour > 6 && hour <= 11 ) {
            dateFormatter = helper.dfAAHM;
        } else if (hour > 11 && hour <= 17) {
            dateFormatter = helper.dfPPHM;
        } else if (hour > 17 && hour <= 24) {
            dateFormatter = helper.dfNightHM;
        } else if (hour < 0 && hour >= -24) {
            dateFormatter = helper.dfYesterdayHM;
        } else {
            dateFormatter = helper.dfYMDHM;
        }
    }
    
    ret = [dateFormatter stringFromDate:date];
    return ret;
}

+ (NSInteger)hoursFromDate:(NSDate *)aFromDate toDate:(NSDate *)aToDate {
    NSTimeInterval ti = [aFromDate timeIntervalSinceDate:aToDate];
    return (NSInteger) (ti / D_HOUR);
}

@end
