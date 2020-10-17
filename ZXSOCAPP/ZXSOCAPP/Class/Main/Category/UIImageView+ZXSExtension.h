//
//  UIImageView+ZXSExtension.h
//  ZXSOCAPP
//
//  Created by ZXS Coder on 2019/4/5.
//  Copyright © 2019 CoderZXS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ZXSExtension)

/**
 设置圆角头像
 */
- (void)zxs_setCircleImageWithImageURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholderImage;

/**
 根据网络不同情况，下载图片，给ImageView控件设置相应的图片
 @param originalImageURLString 大图
 @param thumbnailImageURLString 缩略图
 @param placeholderImage 占位图
 使用这个方法之前需要在AppDelegate.m实现下面的方法去《开始监控网络状况》，这样本方法就能根据网络状态下载图片。
 [[AFNetworkReachabilityManager sharedManager] startMonitoring];
 */
- (void)zxs_setImageWithOriginalImageURLString:(NSString *)originalImageURLString thumbnailImageURLString:(NSString *)thumbnailImageURLString placeholderImage:(UIImage *)placeholderImage options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(nullable SDExternalCompletionBlock)completedBlock;

@end

NS_ASSUME_NONNULL_END
