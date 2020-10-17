#import "AppDelegate+ZXSExtension.h"
#import <iVersion.h>

@implementation AppDelegate (ZXSExtension)

- (void)zxs_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self zxs_configureWindow];
    [self zxs_configureVersionUpdate];
}

- (void)zxs_applicationWillResignActive:(UIApplication *)application {
    
}

- (void)zxs_applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)zxs_applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)zxs_applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)zxs_applicationWillTerminate:(UIApplication *)application {
    
}


#pragma mark - 子方法

- (void)zxs_configureWindow {
    [[UIView appearance] setExclusiveTouch:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[NSClassFromString(@"ZXSTabBarController") alloc] init];
    [self.window makeKeyAndVisible];
}

#pragma mark - 版本升级初始化

- (void)zxs_configureVersionUpdate {
    [iVersion sharedInstance].applicationBundleID = [[NSBundle mainBundle] bundleIdentifier];
}

@end
