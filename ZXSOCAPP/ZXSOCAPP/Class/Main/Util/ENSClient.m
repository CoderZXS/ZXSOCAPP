#import "ENSClient.h"

static ENSClient *shareClient = nil;
@implementation ENSClient

#pragma mark - system

- (instancetype)init {
    if (self = [super init]) {
        self.clientOption = [ENSClientOption getOptionFromLocal];
    }
    return self;
}

#pragma mark - privite

+ (instancetype)shareClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareClient = [[ENSClient alloc] init];
    });
    return shareClient;
}

#pragma mark - custom

@end
