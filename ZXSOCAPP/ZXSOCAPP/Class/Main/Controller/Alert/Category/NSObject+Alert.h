#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Alert)

- (void)showAlertWithMessage:(NSString *)aMsg;

- (void)showAlertWithTitle:(NSString *)aTitle message:(NSString *)aMsg;

@end

NS_ASSUME_NONNULL_END
