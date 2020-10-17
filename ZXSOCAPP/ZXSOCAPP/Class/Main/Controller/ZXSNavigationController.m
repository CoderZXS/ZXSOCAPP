#import "ZXSNavigationController.h"

@interface ZXSNavigationController ()<UINavigationControllerDelegate>

@property (copy, nonatomic) NSArray *hideNavigationBarClasses;

@end

@implementation ZXSNavigationController

#pragma mark - 系统
+ (void)initialize {
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    NSMutableDictionary *itemAttributesDict = [NSMutableDictionary dictionary];
    itemAttributesDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:15.f];
    [[UIBarButtonItem appearance] setTitleTextAttributes:itemAttributesDict forState:UIControlStateNormal];
    
    NSMutableDictionary *barAttributesDict = [NSMutableDictionary dictionary];
    barAttributesDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    barAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:20.f];
    [[UINavigationBar appearance] setTitleTextAttributes:barAttributesDict];
}

+ (void)load {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.9];
    navigationBar.tintColor = [UIColor whiteColor];
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInit];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
    if (self.viewControllers.count > 0) {
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.automaticallyAdjustsScrollViewInsets = YES;
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(didCickBackBarButtonItem:)];
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.hideNavigationBarClasses containsObject:NSStringFromClass([viewController class])]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
        
    } else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

#pragma mark - 事件

- (void)didCickBackBarButtonItem:(UIBarButtonItem *)backBarButtonItem {
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

#pragma mark - 自定义

- (void)setupInit {
    self.delegate = self;
    self.hideNavigationBarClasses = @[];
}

@end
