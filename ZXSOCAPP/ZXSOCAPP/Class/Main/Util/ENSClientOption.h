#import <Foundation/Foundation.h>

static NSString *kOption_isAutoLogin = @"isAutoLogin";
static NSString *kOption_username = @"username";
static NSString *kOption_password = @"password";

NS_ASSUME_NONNULL_BEGIN

@interface ENSClientOption : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL isAutoLogin;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

+ (ENSClientOption *)getOptionFromLocal;

- (void)saveOption;

@end

NS_ASSUME_NONNULL_END
