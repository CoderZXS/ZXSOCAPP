#import "MBProgressHUD.h"

@interface MBProgressHUD (ZXSExtension)

#pragma mark 在指定的view上显示hud
+ (void)zxs_showMessage:(NSString *)message view:(UIView *)view;
+ (void)zxs_showSuccess:(NSString *)success view:(UIView *)view;
+ (void)zxs_showError:(NSString *)error view:(UIView *)view;
+ (void)zxs_showWarning:(NSString *)warning view:(UIView *)view;
+ (void)zxs_showMessage:(NSString *)message icon:(NSString *)icon view:(UIView *)view;
+ (instancetype)zxs_showActivityMessage:(NSString*)message view:(UIView *)view;
+ (instancetype)zxs_showProgressBarWithView:(UIView *)view;

#pragma mark 在window上显示hud
+ (void)zxs_showMessage:(NSString *)message;
+ (void)zxs_showSuccess:(NSString *)success;
+ (void)zxs_showError:(NSString *)error;
+ (void)zxs_showWarning:(NSString *)warning;
+ (void)zxs_showMessage:(NSString *)message icon:(NSString *)icon;
+ (instancetype)zxs_showActivityMessage:(NSString*)message;

#pragma mark 移除hud
+ (void)zxs_hideHUDForView:(UIView *)view;
+ (void)zxs_hideHUD;

@end
