//
//  UIImage+ZXSExtension.h
//  ZXSOCAPP
//
//  Created by ZXS Coder on 2019/4/5.
//  Copyright © 2019 CoderZXS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZXSExtension)

/**
 返回一张去除渲染图片
 */
+ (instancetype)zxs_renderingModeImage:(UIImage *)image;

/**
 对指定图片进行拉伸
 */
+ (instancetype)zxs_resizableImage:(UIImage *)image;

/**
 返回一张受保护图片
 */
+ (instancetype)zxs_stretchableImage:(UIImage *)image;

/**
 * 图片切圆角
 */
+ (instancetype)zxs_circleImageWithImage:(UIImage *)image;

/**
 * 获取指定高度图片
 */
- (instancetype)zxs_imageWithPrefix:(NSString *)prefix height:(NSInteger)height;

/**
 根据颜色返回一张对应的图片
 */
+ (instancetype)zxs_imageWithColor:(UIColor *)color size:(CGSize)size isRound:(BOOL)isRound;

@end

NS_ASSUME_NONNULL_END
