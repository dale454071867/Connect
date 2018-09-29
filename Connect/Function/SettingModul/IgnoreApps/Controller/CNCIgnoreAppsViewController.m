////  CNCIgnoreAppsViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/3.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCIgnoreAppsViewController.h"
#import "CNCIgnoreAppsView.h"
#import "CNCIgnoreAppsCell.h"
#import "CNCSQLManager.h"

@interface CNCIgnoreAppsViewController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) CNCIgnoreAppsView *ignoreAppsView;

@end

@implementation CNCIgnoreAppsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"遗忘之城";
}

- (void)setUI {
    [self.view addSubview:self.ignoreAppsView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return CNCSQL.ignoreAppModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CNCIgnoreAppsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CNCIgnoreAppsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CNCIgnoreAppModel *model = CNCSQL.ignoreAppModels[indexPath.row];
    cell.appIcon.image = [UIImage imageWithData:[NSData dataWithBase64EncodedString:model.appIcon]];
    cell.appName.text = model.appName;
    cell.createTime.text = model.creatTime;
    cell.account.text = model.account;
    return cell;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"重新显示" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [CNCSQL cnc_deleteForIgnoreAppSQLTableWithModel:CNCSQL.ignoreAppModels[indexPath.row]];
        [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
    }];
    return @[delete];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
}

- (CNCIgnoreAppsView *)ignoreAppsView {
    if (!_ignoreAppsView) {
        _ignoreAppsView = [[CNCIgnoreAppsView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _ignoreAppsView.dataSource = self;
        _ignoreAppsView.delegate = self;
    }
    return _ignoreAppsView;
}

@end
