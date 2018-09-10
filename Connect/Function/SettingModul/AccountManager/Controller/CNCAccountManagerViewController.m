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
#import "CNCAccountManagerView.h"
#import "CNCAccountManagerCell.h"
#import "CNCSQLManager.h"

@interface CNCAccountManagerViewController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) CNCAccountManagerView *managerTableView;

@end

@implementation CNCAccountManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号管理";
}

- (void)setUI {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:@"添加" target:self action:@selector(cnc_addAccountDidClick)];
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CNCAccountManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CNCAccountManagerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CNCAccountModel *model = CNCSQL.accountModels[indexPath.section];
    cell.emailLabel.text = [NSString stringWithFormat:@"Apple id:%@", model.email];
    cell.markLabel.text = [NSString stringWithFormat:@"%@:%@", @"备注:", model.mark];
//    cell.lastTimeLabel.text = [NSString stringWithFormat:@"%@%@", @"最后更新时间:", model.lastTime];
    return cell;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(self)weakSelf = self;
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        CNCAccountModel *model = CNCSQL.accountModels[indexPath.section];
        QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:@"" message:@"是否确定删除此账号?" preferredStyle:QMUIAlertControllerStyleAlert];
        [alert addAction:[QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            [CNCSQL cnc_deleteForAccountSQLTableWithModel:model];
            [weakSelf.managerTableView deleteSection:indexPath.section withRowAnimation:UITableViewRowAnimationFade];
        }]];
        [alert addCancelAction];
        [alert showWithAnimated:YES];
    }];
    UITableViewRowAction *edit = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    return @[delete, edit];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (CNCAccountManagerView *)managerTableView {
    if (!_managerTableView) {
        _managerTableView = [[CNCAccountManagerView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _managerTableView.dataSource = self;
        _managerTableView.delegate = self;
        _managerTableView.sectionFooterHeight = CGFLOAT_MIN;
        _managerTableView.sectionHeaderHeight = 10.f;
        _managerTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return _managerTableView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

@end
