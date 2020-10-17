#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXSNetWorkManager : NSObject

/**
 对AFHTTPSessionManager的GET请求方法进行了封装
 
 @param URLString    请求的路径，即 ? 前面部分
 @param parameters   参数
 @param complete     完成回调
 
 @return dataTask
 */
+ (id)zxs_get:(NSString *)URLString
    parameters:(NSDictionary *)parameters
     completionHandler:(void(^)(id responseObj, NSError *error))complete;

/**
 对AFHTTPSessionManager的POST请求方法进行了封装
 
 @param URLString    请求的路径，即 ? 前面部分
 @param parameters   参数
 @param complete     完成回调
 
 @return dataTask
 */
+ (id)zxs_post:(NSString *)URLString
    parameters:(NSDictionary *)parameters
     completionHandler:(void(^)(id responseObj, NSError *error))complete;

/**
 异步下载
 
 @param URLString             文件网络地址
 @param downloadProgressBlock 进度回调
 @param destination           存放位置
 @param completionHandler     完成回调
 */
+ (void)zxs_downloadWithURLString:(NSString *)URLString
                    progress:(void(^)(NSProgress *downloadProgress))downloadProgressBlock
                 destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
           completionHandler:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

/**
 监听网络
 */
+ (void)zxs_monitorNetwork;

@end

NS_ASSUME_NONNULL_END
