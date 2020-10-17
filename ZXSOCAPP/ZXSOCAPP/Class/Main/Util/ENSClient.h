#import <Foundation/Foundation.h>
#import "ENSClientOption.h"

NS_ASSUME_NONNULL_BEGIN

@interface ENSClient : NSObject

@property (nonatomic, strong) ENSClientOption *clientOption;//客户端配置

+ (instancetype)shareClient;

@end

NS_ASSUME_NONNULL_END
