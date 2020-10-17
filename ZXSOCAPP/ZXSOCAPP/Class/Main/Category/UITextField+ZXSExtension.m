//
//  UITextField+ZXSExtension.m
//  ZXSOCAPP
//
//  Created by ZXS Coder on 2019/4/5.
//  Copyright © 2019 CoderZXS. All rights reserved.
//

#import "UITextField+ZXSExtension.h"
#import <objc/message.h>

@implementation UITextField (ZXSExtension)

/*
 使用runtime交换两个方法，使用户不管先设置占位文字，还是占位文字颜色都可以实现设置占位文字颜色自定义。
 */
+ (void)load {
    [super load];
    // 获取系统对象方法设置占位文字setPlaceholder：的方法名
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    // 获取自定义对象方法设置占位文字setZxs_Placeholder：的方法名
    Method setZxs_PlaceholderMethod = class_getInstanceMethod(self, @selector(setZxs_Placeholder:));
    //交换两个方法
    method_exchangeImplementations(setPlaceholderMethod, setZxs_PlaceholderMethod);
}

#pragma mark - 自定义
/**
 设置占位文字颜色(自定义方法)
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    // 添加占位文字颜色成员属性，给成员属性赋值（runtime给系统的类添加成员属性）
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 获取占位文字label控件
    UILabel *placeholderLabel =  [self valueForKey:@"placeholderLabel"];
    // 设置占位文字颜色
    placeholderLabel.textColor = placeholderColor;
}

/**
 获取占位文字颜色(自定义方法)
 */
- (UIColor *)placeholderColor {
    return objc_getAssociatedObject(self, @"placeholderColor");
}

/**
 自定义设置占位文字
 */
- (void)setZxs_Placeholder:(NSString *)placeholder {
    //进入系统的方法设置占位文字（它实际上是调用setPlaceholder:这个方法）
    [self setZxs_Placeholder:placeholder];
    //获取占位文字颜色，然后设置占位文字label上占位文字的颜色。
    self.placeholderColor = self.placeholderColor;
}

@end
