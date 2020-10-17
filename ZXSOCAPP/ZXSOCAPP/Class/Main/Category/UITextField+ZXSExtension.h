//
//  UITextField+ZXSExtension.h
//  ZXSOCAPP
//
//  Created by ZXS Coder on 2019/4/5.
//  Copyright © 2019 CoderZXS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (ZXSExtension)

/**
 提供占位文字颜色属性
 */
@property UIColor *placeholderColor;

/**
 自定义设置占位文字
 */
- (void)setZxs_Placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
