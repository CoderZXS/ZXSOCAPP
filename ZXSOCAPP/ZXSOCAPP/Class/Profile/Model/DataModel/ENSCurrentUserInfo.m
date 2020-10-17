//
//  ENSCurrentUserInfo.m
//  ocdemo
//
//  Created by enesoon on 2020/5/18.
//  Copyright © 2020 enesoon. All rights reserved.
//

#import "ENSCurrentUserInfo.h"

@implementation ENSCurrentUserInfo

+ (instancetype)currentUser {
    static ENSCurrentUserInfo *currentUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentUser = [[ENSCurrentUserInfo alloc] init];
    });
    return currentUser;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivar = class_copyIvarList([ENSCurrentUserInfo class], &count);
        for (NSInteger index = 0; index<count; index++) {
            Ivar iva = ivar[index];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            id value = [decoder decodeObjectForKey:strName];
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    unsigned int count;
    Ivar *ivar = class_copyIvarList([ENSCurrentUserInfo class], &count);
    for (NSInteger index = 0; index <count; index++) {
        Ivar iv = ivar[index];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:strName];
        [encoder encodeObject:value forKey:strName];
    }
    free(ivar);
}

+ (void)saveUserInfo:(ENSCurrentUserInfo *)userInfo {
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.arch"];
    [NSKeyedArchiver archiveRootObject:userInfo toFile:cachePath];
}

+ (ENSCurrentUserInfo *)currentUserInfo {
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.arch"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
}

@end
