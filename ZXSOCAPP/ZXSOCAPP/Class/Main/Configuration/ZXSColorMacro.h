#ifndef ZXSColorMacro_h
#define ZXSColorMacro_h

// 颜色
#define ZXSRGBA_COLOR(R, G, B, A) [UIColor colorWithRed:(R / 255.0f) green:(G / 255.0f) blue:(B / 255.0f) alpha:A]
#define ZXSRGB_COLOR(R, G, B) ZXSRGBA_COLOR(R, G, B, 1.0f)
#define ZXSAPP_BACKGROUND_COLOR ZXSRGBA_COLOR(232, 237, 240, 1.0f)
#define ZXSAPP_THEME_COLOR ZXSRGBA_COLOR(80, 98, 233, 1.0f)
#define ZXSRGBA_RANDOM_COLOR(R, G, B, A) [UIColor colorWithRed:(R / 255.0f) green:(G / 255.0f) blue:(B / 255.0f) alpha:(A / 255.0f)]
#define ZXSRANDOM_COLOR ZXSRGBA_RANDOM_COLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#endif /* ZXSColorMacro_h */
