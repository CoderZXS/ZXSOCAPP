#import <UIKit/UIKit.h>

@interface UIViewController (Util)

- (void)addPopBackLeftItem;

- (void)addPopBackLeftItemWithTarget:(id _Nullable )aTarget action:(SEL _Nullable )aAction;

- (void)addKeyboardNotificationsWithShowSelector:(SEL _Nullable )aShowSelector hideSelector:(SEL _Nullable )aHideSelector;

- (void)removeKeyboardNotifications;

- (void)showAlertControllerWithMessage:(NSString *)aMsg;

@end
