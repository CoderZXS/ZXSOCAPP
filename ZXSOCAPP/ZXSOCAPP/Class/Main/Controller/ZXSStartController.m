#import "ZXSStartController.h"
#import "ZXSTabBarController.h"

@interface ZXSStartController ()

@property (nonatomic, weak) UIImageView *launchImageView;

@end

@implementation ZXSStartController

#pragma mark - 系统
- (void)dealloc {
    [self unRegisterNotification];
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupInit];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
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
- (void)setupUI {
}

- (void)setupInit {
    [self registerNotification];
}

@end
