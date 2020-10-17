#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (ZXSExtension)

- (void)zxs_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)zxs_applicationWillResignActive:(UIApplication *)application;
- (void)zxs_applicationDidEnterBackground:(UIApplication *)application;
- (void)zxs_applicationWillEnterForeground:(UIApplication *)application;
- (void)zxs_applicationDidBecomeActive:(UIApplication *)application;
- (void)zxs_applicationWillTerminate:(UIApplication *)application;

@end

NS_ASSUME_NONNULL_END
