//
//  UIImage+ZXSExtension.m
//  ZXSOCAPP
//
//  Created by ZXS Coder on 2019/4/5.
//  Copyright © 2019 CoderZXS. All rights reserved.
//

#import "UIImage+ZXSExtension.h"

@implementation UIImage (ZXSExtension)

+ (instancetype)zxs_renderingModeImage:(UIImage *)image {
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)zxs_resizableImage:(UIImage *)image {
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
}

+ (instancetype)zxs_stretchableImage:(UIImage *)image {
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (instancetype)zxs_circleImageWithImage:(UIImage *)image {
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    // 获取绘制圆的半径、宽、高 的一个区域
    CGFloat radius = MIN(image.size.width, image.size.height) * 0.5;
    CGFloat width = radius * 2;
    CGFloat height = width;
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // 使用 UIBezierPath 路径裁切，注意：先设置裁切路径，再绘制图像
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    // 添加到裁切路径
    [bezierPath addClip];
    // 将图片绘制到裁切好的区域内
    [image drawInRect:rect];
    // 从上下文获取当前绘制成圆形的图片
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return resImage;
}

- (instancetype)zxs_imageWithPrefix:(NSString *)prefix height:(NSInteger)height {
    NSString *imageName = nil;
    switch (height) {
        case 480:
            imageName = @"iPhone4s";
            break;
            
        case 568:
            imageName = @"iPhoneSE";
            break;
            
        case 667:
            imageName = @"iPhone6";
            break;
            
        case 736:
            imageName = @"iPhone6Plus";
            break;
            
        case 812:
            imageName = @"iPhoneX";
            break;
            
        default:
            imageName = @"iPhoneXSMax";
            break;
    }
    
    imageName = [NSString stringWithFormat:@"%@_%@", prefix,imageName];
    return [UIImage imageNamed:imageName];
}

+ (instancetype)zxs_imageWithColor:(UIColor *)color size:(CGSize)size isRound:(BOOL)isRound {
    CGFloat imageW = size.width;
    CGFloat imageH = size.height;
    // 1.开启基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    if (isRound) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageW, imageH) cornerRadius:(imageH * 0.5)];
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextAddPath(ctx, path.CGPath);
        CGContextClip(ctx);
    }
    
    // 2.画一个color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    // 3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
