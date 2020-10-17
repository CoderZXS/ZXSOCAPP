#import "ENSClientOption.h"

#define kClientOptionFileName @"clientOption.data"
@implementation ENSClientOption

#pragma mark - system

- (instancetype)init {
    if (self = [super init]) {
        self.isAutoLogin = NO;
        self.username = @"";
        self.password = @"";
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.isAutoLogin = [aDecoder decodeBoolForKey:kOption_isAutoLogin];
        self.username = [aDecoder decodeObjectForKey:kOption_username];
        self.password = [aDecoder decodeObjectForKey:kOption_password];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:self.isAutoLogin forKey:kOption_isAutoLogin];
    [aCoder encodeObject:self.username forKey:kOption_username];
    [aCoder encodeObject:self.password forKey:kOption_password];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    ENSClientOption *clientOption = [[[self class] alloc] init];
    clientOption.isAutoLogin = self.isAutoLogin;
    clientOption.username = self.username;
    clientOption.password = self.password;
    return clientOption;
}

#pragma mark - privite
- (void)setUsername:(NSString *)username {
    if (![_username isEqualToString:username]) {
        _username = username;
        _password = @"";
    }
}

#pragma mark - custom

+ (ENSClientOption *)getOptionFromLocal {
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:kClientOptionFileName];
    ENSClientOption *clientOption = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (!clientOption) {
        clientOption = [[ENSClientOption alloc] init];
        [clientOption saveOption];
    }
    return clientOption;
}

- (void)saveOption {
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:kClientOptionFileName];
    [NSKeyedArchiver archiveRootObject:self toFile:file];
}

@end
