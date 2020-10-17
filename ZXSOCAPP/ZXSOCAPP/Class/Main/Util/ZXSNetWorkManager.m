#import "ZXSNetWorkManager.h"
#import<CoreTelephony/CTCellularData.h>
#import "AFNetworking.h"

@interface ZXSNetWorkManager()

@end

@implementation ZXSNetWorkManager

+ (AFHTTPSessionManager *)sessionManager {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    return sessionManager;
}

+ (AFNetworkReachabilityManager *)reachabilityManager {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    return reachabilityManager;
}

// get
+ (id)zxs_get:(NSString *)URLString parameters:(NSDictionary *)parameters completionHandler:(void(^)(id responseObj, NSError *error))complete {
    return [[self sessionManager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil, error);
    }];
}

// post
+ (id)zxs_post:(NSString *)URLString parameters:(NSDictionary *)parameters completionHandler:(void(^)(id responseObj, NSError *error))complete {
    return [[self sessionManager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil, error) ;
    }];
}

// 异步下载
+ (void)zxs_downloadWithURLString:(NSString *)URLString
                    progress:(void(^)(NSProgress *downloadProgress))downloadProgressBlock
                 destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
           completionHandler:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    [[[self sessionManager] downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLString]] progress:downloadProgressBlock destination:destination completionHandler:completionHandler] resume];
}

// 监听网络
+ (void)zxs_monitorNetwork {
    if (@available(iOS 10.0, *)) {
        // 1.获取网络权限
        [self zxs_checkNetworkPermission];
        
    } else {
        // 2.监听网络状态
        [self zxs_monitorNetworkStatus];
    }
}

// 获取网络权限
+ (void)zxs_checkNetworkPermission {
    // CTCellularData在iOS9之前是私有类，权限设置是iOS10开始的，所以App Store审核没有问题，获取网络权限状态
    if (@available(iOS 9.0, *)) {
        CTCellularData *cellularData = [[CTCellularData alloc] init];
        // 此函数会在网络权限改变时再次调用
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
            switch (state) {
                case kCTCellularDataRestricted: {
                    ZXSLOG(@"Restricted");
                    // 2.1权限关闭的情况下 再次请求网络数据会弹出设置网络提示
                    [self zxs_monitorNetworkStatus];
                }
                    break;
                    
                case kCTCellularDataNotRestricted: {
                    ZXSLOG(@"NotRestricted");
                    // 2.2已经开启网络权限 监听网络状态
                    [self zxs_monitorNetworkStatus];
                }
                    break;
                    
                case kCTCellularDataRestrictedStateUnknown: {
                    ZXSLOG(@"Unknown");
                    // 2.3未知情况（还没有遇到推测是有网络但是连接不正常的情况下）
                    [self zxs_monitorNetworkStatus];
                }
                    break;
                    
                default:
                    break;
            }
        };
        
    } else {
        // Fallback on earlier versions
    }
    
}

// 监听网络状态
+ (void)zxs_monitorNetworkStatus {
    [[self reachabilityManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                ZXSLOG(@"网络不通：%@",@(status));
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                ZXSLOG(@"网络通过WIFI连接：%@",@(status));
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                ZXSLOG(@"网络通过无线连接：%@",@(status));
            }
                break;
                
            default:
                break;
        }
    }];
    
    // 开启网络监视器；
    [[self reachabilityManager] startMonitoring];
}

@end
