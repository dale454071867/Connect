////  CNCQueryViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/10.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCApplicationViewController.h"
#import "CNCQueryViewController.h"
#import "CNCNotification.h"
#import "CNCSQLManager.h"
#import "CNCQueryView.h"
#import "CNCQueryCell.h"

@interface CNCQueryViewController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) CNCQueryView *queryView;

@end

@implementation CNCQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CNCNotification cnc_addObserver:self selector:@selector(cnc_reloadData) name:kQUERYRELOADDATA];
}

- (void)setUI {
    [self.view addSubview:self.queryView];
}

- (void)cnc_reloadData {
    [self.queryView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return CNCSQL.accountModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CNCQueryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CNCQueryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CNCAccountModel *model = CNCSQL.accountModels[indexPath.row];
    cell.emailLabel.text = [NSString stringWithFormat:@"账号: %@", model.email];
    cell.markLabel.text = [NSString stringWithFormat:@"备注: %@", model.mark];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    CNCApplicationViewController *application = [[CNCApplicationViewController alloc] init];
    application.accountModel = CNCSQL.accountModels[indexPath.row];
    [self.navigationController pushViewController:application animated:YES];
}

- (CNCQueryView *)queryView {
    if (!_queryView) {
        _queryView = [[CNCQueryView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _queryView.dataSource = self;
        _queryView.delegate = self;
    }
    return _queryView;
}

- (void)dealloc {
    [CNCNotification cnc_removeObserver:self name:kQUERYRELOADDATA];
}

@end
