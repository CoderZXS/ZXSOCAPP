//
//  ZXSImageAlignmentButton.h
//  ZXSOCAPP
//
//  Created by ZXS Coder on 2019/4/6.
//  Copyright © 2019 CoderZXS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  按钮中图片的位置
 */
typedef NS_ENUM(NSUInteger, ZXSImageAlignment) {
    ZXSImageAlignmentLeft = 0,// 图片在左，默认
    ZXSImageAlignmentTop,// 图片在上
    ZXSImageAlignmentBottom,// 图片在下
    ZXSImageAlignmentRight,// 图片在右
};

@interface ZXSImageAlignmentButton : UIButton

@property (nonatomic,assign) ZXSImageAlignment imageAlignment;// 按钮中图片的位置
@property (nonatomic,assign) CGFloat space;// 按钮中图片与文字的间距

@end

NS_ASSUME_NONNULL_END
