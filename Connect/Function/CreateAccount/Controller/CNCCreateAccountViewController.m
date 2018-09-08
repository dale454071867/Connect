////  CNCCreateAccountViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/3.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCCreateAccountViewController.h"
#import "CNCCreateAccountModel.h"
#import "CNCCreateAccountCell.h"
#import "NSDate+CNCExtension.h"
#import "CNCSQLManager.h"

@interface CNCCreateAccountViewController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) QMUITableView *createTableView;

@property(nonatomic, strong) CNCCreateAccountModel *model;

@end

@implementation CNCCreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"add", nil);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:NSLocalizedString(@"save", nil) target:self action:@selector(cnc_saveDidClick)];;
}

- (void)setUI {
    [self.view addSubview:self.createTableView];
}

- (void)cnc_saveDidClick {
    __block BOOL result = NO;
    __weak __typeof(self)weakSelf = self;
    CNCAccountModel *model = [CNCAccountModel new];
    [self.model.models enumerateObjectsUsingBlock:^(CNCCreateAccountModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       CNCCreateAccountCell *cell = [weakSelf.createTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
        NSString *value = cell.content.text.qmui_trimAllWhiteSpace;
        result = value.length;
        if (result) {
            [model setValue:value forKey:obj.key];
        }else {
            *stop = YES;
            QMUIAlertController *alert = [[QMUIAlertController alloc] initWithTitle:nil message:@"Please input content" preferredStyle:QMUIAlertControllerStyleAlert];
            [alert addCancelAction];
            [alert showWithAnimated:YES];
        }
    }];
    if (result) {
        [model setValue:[NSDate cnc_currentTime] forKey:@"lastTime"];
        [CNCSQL cnc_putToAccountSQLTableWithModel:model];
        if (self.cnc_updateAccountTableView) {
            self.cnc_updateAccountTableView();
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CNCCreateAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CNCCreateAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CNCCreateAccountModel *model = self.model.models[indexPath.row];
    cell.title.text = model.title;
    cell.content.placeholder = [NSString stringWithFormat:@"Please input content"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (QMUITableView *)createTableView {
    if (!_createTableView) {
        _createTableView = [[QMUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _createTableView.dataSource = self;
        _createTableView.delegate = self;
        _createTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, SCREEN_WIDTH*.3)];
    }
    return _createTableView;
}

- (CNCCreateAccountModel *)model {
    if (!_model) {
        _model = [CNCCreateAccountModel new];
    }
    return _model;
}

@end
