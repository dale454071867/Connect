////  CNCAccountManagerController.m
//  Connect
//
//  Created by Dwang on 2018/9/3.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCAccountManagerController.h"
#import "CNCCreateAccountController.h"
#import "CNCAccountManagerView.h"
#import "CNCAccountManagerCell.h"
#import "CNCNotification.h"
#import "CNCSQLManager.h"

@interface CNCAccountManagerController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) CNCAccountManagerView *managerTableView;

@end

@implementation CNCAccountManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"账号管理";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:@"添加" target:self action:@selector(cnc_addAccountDidClick)];
}

- (void)setUI {
     [self.view addSubview:self.managerTableView];
}

- (void)cnc_addAccountDidClick {
    [self cnc_pushCreateAccountViewControllerForRowAtIndexPath:nil];
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
    cell.markLabel.text = [NSString stringWithFormat:@"%@:%@", @"备注", model.mark];
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
            [CNCNotification cnc_postNotificationName:kACCOUNTDATACHANGE object:indexPath];
            [weakSelf.managerTableView deleteSection:indexPath.section withRowAnimation:UITableViewRowAnimationFade];
        }]];
        [alert addCancelAction];
        [alert showWithAnimated:YES];
    }];
    UITableViewRowAction *edit = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [weakSelf cnc_pushCreateAccountViewControllerForRowAtIndexPath:indexPath];
    }];
    edit.backgroundColor = UIColorBlue;
    return @[delete, edit];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    [self cnc_pushCreateAccountViewControllerForRowAtIndexPath:indexPath];
}

- (void)cnc_pushCreateAccountViewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(self)weakSelf = self;
    CNCCreateAccountController *create = [[CNCCreateAccountController alloc] init];
    create.cnc_accountOperateTypeCallBack = ^(CNCAccountOperateType operateType) {
        if (operateType == CNCAccountOperateTypeCreate) {
            [weakSelf.managerTableView insertSection:0 withRowAnimation:UITableViewRowAnimationFade];
            [CNCNotification cnc_postNotificationName:kACCOUNTDATACHANGE];
        }else {
            [weakSelf.managerTableView moveSection:indexPath.section toSection:0];
            [weakSelf.managerTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationFade];
            [CNCNotification cnc_postNotificationName:kACCOUNTDATACHANGE object:@(indexPath.section)];
        }
    };
    if (indexPath) {
        create.title = @"编辑账号信息";
        create.accountModel = CNCSQL.accountModels[indexPath.section];
    }else {
        create.title = @"新建账号";
        create.accountModel = nil;
    }
    [self.navigationController pushViewController:create animated:YES];
}

- (CNCAccountManagerView *)managerTableView {
    if (!_managerTableView) {
        _managerTableView = [[CNCAccountManagerView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _managerTableView.sectionFooterHeight = CGFLOAT_MIN;
        _managerTableView.sectionHeaderHeight = 10.f;
        _managerTableView.dataSource = self;
        _managerTableView.delegate = self;
        _managerTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return _managerTableView;
}

@end
