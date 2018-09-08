////  CNCAccountManagerViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/3.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCAccountManagerViewController.h"
#import "CNCCreateAccountViewController.h"
#import "CNCAccountManagerCell.h"
#import "CNCSQLManager.h"

@interface CNCAccountManagerViewController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) QMUITableView *managerTableView;

@end

@implementation CNCAccountManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"accountManager", nil);
}

- (void)setUI {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:NSLocalizedString(@"add", nil) target:self action:@selector(cnc_addAccountDidClick)];
    [self.view addSubview:self.managerTableView];
}

- (void)cnc_addAccountDidClick {
    CNCCreateAccountViewController *create = [[CNCCreateAccountViewController alloc] init];
    __weak __typeof(self)weakSelf = self;
    create.cnc_updateAccountTableView = ^{
        [weakSelf.managerTableView reloadData];
    };
    [self.navigationController pushViewController:create animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return CNCSQL.accountModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CNCAccountManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CNCAccountManagerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CNCAccountModel *model = CNCSQL.accountModels[indexPath.section];
    cell.emailLabel.text = model.email;
    cell.lastTimeLabel.text = model.lastTime;
    return cell;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(self)weakSelf = self;
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:NSLocalizedString(@"delete", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        CNCAccountModel *model = CNCSQL.accountModels[indexPath.section];
        QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"are you delete this account?", nil) preferredStyle:QMUIAlertControllerStyleAlert];
        [alert addAction:[QMUIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            [CNCSQL cnc_deleteForAccountSQLTableWithModel:model];
            [weakSelf.managerTableView deleteSection:indexPath.section withRowAnimation:UITableViewRowAnimationFade];
        }]];
        [alert addCancelAction];
        [alert showWithAnimated:YES];
    }];
    UITableViewRowAction *edit = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:NSLocalizedString(@"edit", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    return @[delete, edit];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (QMUITableView *)managerTableView {
    if (!_managerTableView) {
        _managerTableView = [[QMUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _managerTableView.dataSource = self;
        _managerTableView.delegate = self;
        _managerTableView.sectionFooterHeight = 10.f;
        _managerTableView.sectionHeaderHeight = CGFLOAT_MIN;
        _managerTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return _managerTableView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

@end
