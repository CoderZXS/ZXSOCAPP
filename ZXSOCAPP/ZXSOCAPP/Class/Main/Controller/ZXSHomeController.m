#import "ZXSHomeController.h"
#import "ZXSTabBarController.h"

@interface ZXSHomeController ()

@end


@implementation ZXSHomeController

#pragma mark - 懒加载
#pragma mark - 系统

- (void)dealloc {
    [self unRegisterNotification];
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupInit];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置导航栏背景图片为一个空的image，这样就透明了
    UIImage *image = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // 去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:image];
    // 上面两条代码会使导航栏变透明，如果不想让其他页面的导航栏变为透明需要重置
    // [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    // [self.navigationController.navigationBar setShadowImage:nil];
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

#pragma mark - 事件
#pragma mark - 通知

- (void)registerNotification {
}

- (void)unRegisterNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 自定义

- (void)setupNavigationBar {
}

- (void)setupInit {
    self.view.backgroundColor = ZXSRANDOM_COLOR;
    [self registerNotification];
}

@end
