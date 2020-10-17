#ifndef ZXSScreenMacro_h
#define ZXSScreenMacro_h

#define ZXSIS_iPhoneX (\
{\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);}\
)

#define ZXSVIEW_TOP_MARGIN (ZXSIS_iPhoneX ? 22.f : 0.f)
#define ZXSVIEW_BOTTOM_MARGIN (ZXSIS_iPhoneX ? 34.f : 0.f)

// 设备类型
#define ZXSIPHONE4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define ZXSIPHONESE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ZXSIPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define ZXSIPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define ZXSIPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define ZXSIPHONE_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define ZXSIPHONE_XSMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define ZXSIPHONE_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

// 全面屏
#define ZXSISFULLSCREEN (ZXSIPHONE_X || ZXSIPHONE_XS || ZXSIPHONE_XSMAX || ZXSIPHONE_XR)
#define ZXSISNORMALFONT (ZXSIPHONE4S || ZXSIPHONESE || ZXSIPHONE6 || ZXSIPHONE6PLUS)

#define ZXSSTATUS_BAR_HEIGHT (ZXSISFULLSCREEN ? 44.f : 20.f)
#define ZXSSTATUS_BAR_NAVIGATION_BAR_HEIGHT (ZXSISFULLSCREEN ? 88.f : 64.f)
#define ZXSNAVIGATION_BAR_HEIGHT 44.f
#define ZXSTAB_BAR_SAFE_BOTTOM_MARGIN (ZXSISFULLSCREEN ? 34.f : 0.f)
#define ZXSTAB_BAR_HEIGHT (ZXSISFULLSCREEN ? (83.f) : 49.f)

// 屏幕尺寸
#define ZXSSCREEN_BOUNDS [UIScreen mainScreen].bounds
#define ZXSSCREEN_SIZE [UIScreen mainScreen].bounds.size
#define ZXSSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define ZXSSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 适配比
#define ZXSWIDTH(value) ((value) * ZXSSCREEN_WIDTH / 375.0f) // 6为标准适配
#define ZXSHEIGHT(value) ((value) * ZXSSCREEN_HEIGHT / 667.0f)
#define ZXSFONT(value) (ZXSISNORMALFONT ? value : (value + 2))

#endif /* ZXSScreenMacro_h */
