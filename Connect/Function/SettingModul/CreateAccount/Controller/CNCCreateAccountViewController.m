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
#import "CNCCreateAccountView.h"
#import "CNCCreateAccountCell.h"
#import "NSDate+CNCExtension.h"
#import "CNCNotification.h"
#import "CNCSQLManager.h"

@interface CNCCreateAccountViewController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) CNCCreateAccountView *createTableView;

@property(nonatomic, strong) CNCCreateAccountModel *model;

@property(nonatomic, copy) NSArray<NSString *> *texts;

@end

@implementation CNCCreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:@"保存" target:self action:@selector(cnc_saveDidClick)];
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
            BOOL *b = stop;
            if (idx == 0 && !weakSelf.accountModel) {
                if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", kEMailRegular] evaluateWithObject:value]) {
                    [CNCSQL.accountModels enumerateObjectsUsingBlock:^(CNCAccountModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (ISEqualToString(value, obj.email)) {
                            *b = YES;
                            *stop = YES;
                            result = NO;
                            QMUIAlertController *alert = [[QMUIAlertController alloc] initWithTitle:nil message:@"当前输入的账号已存在" preferredStyle:QMUIAlertControllerStyleAlert];
                            [alert addCancelAction];
                            [alert showWithAnimated:YES];
                        }
                    }];
                }else {
                    *b = YES;
                    *stop = YES;
                    result = NO;
                    QMUIAlertController *alert = [[QMUIAlertController alloc] initWithTitle:nil message:@"请输入正确的邮箱信息" preferredStyle:QMUIAlertControllerStyleAlert];
                    [alert addCancelAction];
                    [alert showWithAnimated:YES];
                }
            }
            if (!*b) {
                [model setValue:value forKey:obj.key];
            }
        }else {
            *stop = YES;
            QMUIAlertController *alert = [[QMUIAlertController alloc] initWithTitle:nil message:@"请输入对应的内容" preferredStyle:QMUIAlertControllerStyleAlert];
            [alert addCancelAction];
            [alert showWithAnimated:YES];
        }
    }];
    if (result) {
        [model setValue:[NSDate cnc_currentDate] forKey:@"lastTime"];
        if (self.accountModel) {
            [CNCSQL cnc_editForAccountSQLTableWithModel:model];
        }else{
            [CNCSQL cnc_putToAccountSQLTableWithModel:model];
        }
        if (self.cnc_accountOperateTypeCallBack) {
            self.cnc_accountOperateTypeCallBack(self.accountModel?CNCAccountOperateTypeEdit:CNCAccountOperateTypeCreate);
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
    if (self.accountModel) {
        cell.content.enabled = indexPath.row;
        cell.content.text = self.texts[indexPath.row];
    }
    
    CNCCreateAccountModel *model = self.model.models[indexPath.row];
    cell.title.text = [NSString stringWithFormat:@"%@:", model.title];
    cell.content.placeholder = [NSString stringWithFormat:@"请在当前位置输入%@内容", model.title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (CNCCreateAccountView *)createTableView {
    if (!_createTableView) {
        _createTableView = [[CNCCreateAccountView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
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

- (NSArray<NSString *> *)texts {
    if (!_texts) {
        _texts = @[self.accountModel.email, self.accountModel.developer_password, self.accountModel.mark];
    }
    return _texts;
}

@end
