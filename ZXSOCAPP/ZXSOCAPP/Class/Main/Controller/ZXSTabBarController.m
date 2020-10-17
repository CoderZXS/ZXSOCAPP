#import "ZXSTabBarController.h"
#import "ZXSNavigationController.h"

@interface ZXSTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ZXSTabBarController

#pragma mark - 懒加载
#pragma mark - 系统
- (void)dealloc {
    [self unRegisterNotification];
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVC];
    [self setupInit];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 通知
- (void)registerNotification {
}

- (void)unRegisterNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 自定义
- (void)setupChildVC {
    [self addChildVCWithName:@"ZXSHomeController" title:@"主页" imageName:@"tabbar_home_image_normal" selectedImageName:@"tabbar_home_image_selected"];
    [self addChildVCWithName:@"ZXSMeController" title:@"我的" imageName:@"tabbar_me_image_normal" selectedImageName:@"tabbar_me_image_selected"];
}

- (void)setupInit {
    [self registerNotification];
}

- (void)addChildVCWithName:(NSString *)name {
    UIViewController *vc = [[NSClassFromString(name) alloc] init];
    ZXSNavigationController *nav = [[ZXSNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (void)addChildVCWithName:(NSString *)name title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    UIViewController *vc = [[NSClassFromString(name) alloc] init];
    ZXSNavigationController *nav = [[ZXSNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    //nav.tabBarItem.image = [UIImage imageNamed:imageName];
    //nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    [self addChildViewController:nav];
}



@end
