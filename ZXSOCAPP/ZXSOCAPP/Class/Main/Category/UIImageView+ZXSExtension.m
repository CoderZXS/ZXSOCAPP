//
//  UIImageView+ZXSExtension.m
//  ZXSOCAPP
//
//  Created by ZXS Coder on 2019/4/5.
//  Copyright © 2019 CoderZXS. All rights reserved.
//

#import "UIImageView+ZXSExtension.h"
#import "AFNetworking.h"
#import "UIImage+ZXSExtension.h"

@implementation UIImageView (ZXSExtension)

/**
 设置圆角头像
 */
- (void)zxs_setCircleImageWithImageURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholderImage {
    //获取圆角占位图
    UIImage *circlePlaceholderImage = [UIImage zxs_circleImageWithImage:placeholderImage];
    //设置圆角图片
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:imageURL placeholderImage:circlePlaceholderImage options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 图片下载失败，直接返回，按照它的默认做法,显示占位图片
        if (nil == image) return;
        
        //将下载的图片进行圆角化
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.image = [UIImage zxs_circleImageWithImage:image];
    }];
}

/**
 根据网络不同情况，下载图片，给ImageView控件设置相应的图片
 @param originalImageURLString 大图
 @param thumbnailImageURLString 缩略图
 @param placeholderImage 占位图
 使用这个方法之前需要在AppDelegate.m实现下面的方法去《开始监控网络状况》，这样本方法就能根据网络状态下载图片。
 [[AFNetworkReachabilityManager sharedManager] startMonitoring];
 */
- (void)zxs_setImageWithOriginalImageURLString:(NSString *)originalImageURLString thumbnailImageURLString:(NSString *)thumbnailImageURLString placeholderImage:(UIImage *)placeholderImage options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(nullable SDExternalCompletionBlock)completedBlock {
    
    // 根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 获得原图（SDWebImage的图片缓存是用图片的url字符串作为key）
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalImageURLString];
    if (originalImage) { // 原图已经被下载过
        
        //使用下面的方法的原因是它会移除上一次下载图片请求，这样在网络状态很差的时候，就不会出现图片紊乱的问题。
        [self sd_setImageWithURL:[NSURL URLWithString:originalImageURLString] placeholderImage:placeholderImage options:options progress:progressBlock completed:completedBlock];
    } else { // 原图并未下载过
        
        if (mgr.isReachableViaWiFi) {//WiFi
            [self sd_setImageWithURL:[NSURL URLWithString:originalImageURLString] placeholderImage:placeholderImage options:options progress:progressBlock completed:completedBlock];
        } else if (mgr.isReachableViaWWAN) {//蜂窝数据
            
            // 3G\4G网络下时候要下载原图
#warning TODO:获取app是否设置了在3GOr4G网络下是否下载原图
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self sd_setImageWithURL:[NSURL URLWithString:originalImageURLString] placeholderImage:placeholderImage options:options progress:progressBlock completed:completedBlock];
            } else {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURLString] placeholderImage:placeholderImage options:options progress:progressBlock completed:completedBlock];
            }
        } else { // 没有可用网络
            
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURLString];
            if (thumbnailImage) { // 缩略图已经被下载过
                //使用下面的方法的原因是它会移除上一次下载图片请求，这样在网络状态很差的时候，就不会出现图片紊乱的问题。
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURLString] placeholderImage:placeholderImage options:options progress:progressBlock completed:completedBlock];
            } else { // 没有下载过任何图片
                [self sd_setImageWithURL:nil placeholderImage:placeholderImage options:options progress:progressBlock completed:completedBlock];
            }
        }
    }
}

@end
