#import "MBProgressHUD+ZXSExtension.h"

// 统一的显示时长
#define ZXSHudShowTime 2.0f

@implementation MBProgressHUD (ZXSExtension)

#pragma mark 在指定的view上显示hud
// 显示一条信息
+ (void)zxs_showMessage:(NSString *)message view:(UIView *)view {
    [self zxs_show:message icon:nil view:view];
}

// 显示成功信息
+ (void)zxs_showSuccess:(NSString *)success view:(UIView *)view {
    [self zxs_show:success icon:@"success.png" view:view];
}

// 显示错误信息
+ (void)zxs_showError:(NSString *)error view:(UIView *)view {
    [self zxs_show:error icon:@"error.png" view:view];
}

// 显示警告信息
+ (void)zxs_showWarning:(NSString *)warning view:(UIView *)view {
    [self zxs_show:warning icon:@"warn.png" view:view];
}

// 显示自定义图片信息
+ (void)zxs_showMessage:(NSString *)message icon:(NSString *)icon view:(UIView *)view {
    [self zxs_show:message icon:icon view:view];
}

// 加载中
+ (instancetype)zxs_showActivityMessage:(NSString*)message view:(UIView *)view {
    if (!view) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 细节文字
    // hud.detailsLabelText = @"请耐心等待";
    // 再设置模式
    hud.mode = MBProgressHUDModeIndeterminate;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (instancetype)zxs_showProgressBarWithView:(UIView *)view {
    if (!view) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = @"加载中...";
    
    return hud;
}


#pragma mark 在window上显示hud
+ (void)zxs_showMessage:(NSString *)message {
    [self zxs_showMessage:message view:nil];
}

+ (void)zxs_showSuccess:(NSString *)success {
    [self zxs_showSuccess:success view:nil];
}

+ (void)zxs_showError:(NSString *)error {
    [self zxs_showError:error view:nil];
}

+ (void)zxs_showWarning:(NSString *)warning {
    [self zxs_showWarning:warning view:nil];
}

+ (void)zxs_showMessage:(NSString *)message icon:(NSString *)icon {
    [self zxs_showMessage:message icon:icon view:nil];
}

+ (instancetype)zxs_showActivityMessage:(NSString*)message {
    return [self zxs_showActivityMessage:message view:nil];
}

#pragma mark 移除hud
+ (void)zxs_hideHUDForView:(UIView *)view {
    if (!view) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    [self hideHUDForView:view animated:YES];
}

+ (void)zxs_hideHUD {
    [self zxs_hideHUDForView:nil];
}

#pragma mark 显示带图片或者不带图片的信息
+ (void)zxs_show:(NSString *)message icon:(NSString *)icon view:(UIView *)view {
    if (!view) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    
    // 判断是否显示图片
    if (!icon) {
        hud.mode = MBProgressHUDModeText;
        //设置文字左边和边框左边间距
        hud.margin = 10.f;
        //将边框向下移动
        CGPoint tempoffset = hud.offset;
        tempoffset.y = 150.f;
        hud.offset = tempoffset;
        // YES代表需要蒙版效果
        hud.backgroundColor = [UIColor blackColor];
        
    } else {
        // 设置图片
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]];
        img = img ? [UIImage imageNamed:icon] : img;
        hud.customView = [[UIImageView alloc] initWithImage:img];
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
        
    }

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 指定时间之后再消失
    [hud hideAnimated:YES afterDelay:ZXSHudShowTime];
}

@end
