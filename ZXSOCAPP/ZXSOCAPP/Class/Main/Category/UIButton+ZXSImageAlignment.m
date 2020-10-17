//
//  UIButton+ZXSImageAlignment.m
//  ZXSOCAPP
//
//  Created by ZXS Coder on 2019/4/5.
//  Copyright © 2019 CoderZXS. All rights reserved.
//

/**纯代码创建按钮
 - 第一种通过分类的方式设置按钮非常方便，只需要一行代码就足够了，不需要我们自己计算UIEngeInsetsMake，适用于纯代码创建的按钮。 如果是Xib创建的按钮就用不了。
 
 - 第二种通过继承的方式重写layoutSubviews的方式设置按钮好处是既适用于纯代码创建的按钮，也适用于Xib创建的按钮，但是这种方法有一定的局限性，它只适用于同一类型的按钮。一类比如我一个界面中有几种不同类型的按钮，这时候就需要我们创建不同的继承UIButton 的按钮类，在layoutSubviews设置不同的位置关系。这样就相对复杂了。
 */


#import "UIButton+ZXSImageAlignment.h"

@implementation UIButton (ZXSImageAlignment)

- (void)zxs_layoutButtonWithImageAlignment:(ZXSImageAlignment)imageAlignment space:(CGFloat)space {
    /**
     知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     如果只有title，那它上下左右都是相对于button的，image也是一样；
     如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
        
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据imageAlignment和space得到imageEdgeInsets和labelEdgeInsets的值
    CGFloat halfSpace = space * 0.5;
    switch (imageAlignment) {
        case ZXSImageAlignmentTop: {
            imageEdgeInsets = UIEdgeInsetsMake(-(labelHeight + halfSpace), 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -(imageHeight + halfSpace), 0);
        }
            break;
            
        case ZXSImageAlignmentLeft: {
            imageEdgeInsets = UIEdgeInsetsMake(0, -halfSpace, 0, halfSpace);
            labelEdgeInsets = UIEdgeInsetsMake(0, halfSpace, 0, -halfSpace);
        }
            break;
            
        case ZXSImageAlignmentBottom: {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -(labelHeight + halfSpace), -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-(imageHeight + halfSpace), -imageWith, 0, 0);
        }
            break;
            
        case ZXSImageAlignmentRight: {
            imageEdgeInsets = UIEdgeInsetsMake(0, (labelWidth + halfSpace), 0, -(labelWidth + halfSpace));
            labelEdgeInsets = UIEdgeInsetsMake(0, -(imageWith + halfSpace), 0, (imageWith + halfSpace));
        }
            break;
            
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
