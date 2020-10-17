//
//  SceneDelegate.m
//  ZXSOCAPP
//
//  Created by enesoon on 2020/10/16.
//

#import "SceneDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}

/*
 * 在应用程序处于非活动状态时，重新启动暂停（或尚未启动）的任何任务。 如果应用程序以前位于后台，则可以选择刷新用户界面。
 */

- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}

/*
 * 当应用程序即将从活动状态转移到非活动状态时发送。 对于某些类型的临时中断（例如来电或SMS消息）或用户退出应用程序并开始转换到后台状态时，可能会发生这种情况。使用此方法暂停正在进行的任务，禁用定时器，并使图形呈现回调无效。 游戏应该使用这种方法来暂停游戏。
 */
- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}

/*
 * 被称为从背景到活动状态的转换的一部分; 在这里你可以撤消进入背景的许多变化。
 */
- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}

/*
 * 使用此方法释放共享资源，保存用户数据，使计时器无效，并存储足够的应用程序状态信息，以便将应用程序恢复到当前状态，以防以后终止。如果您的应用程序支持后台执行，则调用此方法而不是applicationWillTerminate：当用户退出时。
 */
- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
