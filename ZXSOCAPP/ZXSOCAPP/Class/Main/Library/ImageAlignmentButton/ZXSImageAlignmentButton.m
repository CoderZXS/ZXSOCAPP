//
//  ZXSImageAlignmentButton.m
//  ZXSOCAPP
//
//  Created by ZXS Coder on 2019/4/6.
//  Copyright © 2019 CoderZXS. All rights reserved.
//

#import "ZXSImageAlignmentButton.h"

@implementation ZXSImageAlignmentButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat space = self.space;
    CGFloat titleW = CGRectGetWidth(self.titleLabel.bounds);// titleLabel的宽度
    CGFloat titleH = CGRectGetHeight(self.titleLabel.bounds);// titleLabel的高度
    CGFloat imageW = CGRectGetWidth(self.imageView.bounds);// imageView的宽度
    CGFloat imageH = CGRectGetHeight(self.imageView.bounds);// imageView的高度
    CGFloat btnCenterX = CGRectGetWidth(self.bounds) * 0.5;// 按钮中心点X的坐标（以按钮左上角为原点的坐标系）
    CGFloat imageCenterX = btnCenterX - titleW * 0.5;// imageView中心点X的坐标（以按钮左上角为原点的坐标系）
    CGFloat titleCenterX = btnCenterX + imageW * 0.5;// titleLabel中心点X的坐标（以按钮左上角为原点的坐标系）
    
    switch (self.imageAlignment) {
            case ZXSImageAlignmentTop: {
            self.titleEdgeInsets = UIEdgeInsetsMake(imageH/2+ space/2, -(titleCenterX-btnCenterX), -(imageH/2 + space/2), titleCenterX-btnCenterX);
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleH/2 + space/2), btnCenterX-imageCenterX, titleH/2+ space/2, -(btnCenterX-imageCenterX));
        }
            break;
            
            case ZXSImageAlignmentLeft: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2, 0,  -space/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space);
        }
            break;
            
            case ZXSImageAlignmentBottom: {
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageH/2+ space/2), -(titleCenterX-btnCenterX), imageH/2 + space/2, titleCenterX-btnCenterX);
            self.imageEdgeInsets = UIEdgeInsetsMake(titleH/2 + space/2, btnCenterX-imageCenterX,-(titleH/2+ space/2), -(btnCenterX-imageCenterX));
        }
            break;
            
            case ZXSImageAlignmentRight: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageW + space/2), 0, imageW + space/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW+space/2, 0, -(titleW+space/2));
        }
            break;
            
        default:
            break;
    }
}

@end
