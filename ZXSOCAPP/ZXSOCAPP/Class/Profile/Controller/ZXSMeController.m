#import "ZXSMeController.h"

@interface ZXSMeController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ZXSMeController

#pragma mark - 系统

- (void)dealloc {
    
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
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

#pragma mark - UITableViewDataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
//    return 5;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}

#pragma mark - 事件

- (void)leftBarButtonItemDidClick {
}

#pragma mark - 自定义

- (void)setupNavigationBar {
}

- (void)setupInit {
    self.view.backgroundColor = ZXSRANDOM_COLOR;
}

@end
