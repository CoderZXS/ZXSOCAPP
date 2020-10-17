//
//  UIButton+ZXSImageAlignment.h
//  ZXSOCAPP
//
//  Created by ZXS Coder on 2019/4/5.
//  Copyright © 2019 CoderZXS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, ZXSImageAlignment) {
    ZXSImageAlignmentTop,     // image在上，label在下
    ZXSImageAlignmentLeft,    // image在左，label在右
    ZXSImageAlignmentBottom,  // image在下，label在上
    ZXSImageAlignmentRight    // image在右，label在左
};

@interface UIButton (ZXSImageAlignment)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *  使用本方法之前需要先设置好按钮的frame和image、title
 *  @param imageAlignment titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)zxs_layoutButtonWithImageAlignment:(ZXSImageAlignment)imageAlignment space:(CGFloat)space;


@end

NS_ASSUME_NONNULL_END
