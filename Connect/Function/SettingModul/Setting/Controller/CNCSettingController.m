////  CNCSettingController.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//    QQ群:    577506623
//    GitHub:    https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCAccountManagerController.h"
#import "CNCIgnoreAppsController.h"
#import "CNCSettingController.h"
#import "CNCSettingHeaderView.h"
#import "NSDate+CNCExtension.h"
#import "CNCSettingModel.h"
#import "CNCSettingView.h"
#import "CNCSettingCell.h"
#import "CNCSQLManager.h"
#import <JPUSHService.h>

@interface CNCSettingController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) CNCSettingView *settingTableView;

@property(nonatomic, strong) CNCSettingModel *model;

@end

@implementation CNCSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    [self.view addSubview:self.settingTableView];
}

- (void)setNetwork {
    [JPUSHService setAlias:[UIDevice currentDevice].name completion:nil seq:[NSDate cnc_currentDateWithFormat:@"YYYYMMddhhmmss"].integerValue];
    [JPUSHService validTag:[UIDevice currentDevice].name completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq, BOOL isBind) {
        if (!isBind) {
            [JPUSHService addTags:[NSSet setWithObject:[UIDevice currentDevice].name] completion:nil seq:[NSDate cnc_currentDateWithFormat:@"YYYYMMddhhmmss"].integerValue];
        }
    } seq:[NSDate cnc_currentDateWithFormat:@"YYYYMMddhhmmss"].integerValue];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.models[section].count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CNCSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CNCSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    CNCSettingModel *model = self.model.models[indexPath.section][indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.detail;
    cell.backgroundColor = UIColorWhite;
    cell.textLabel.textColor = UIColorBlack;
    cell.detailTextLabel.textColor = UIColorGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.enabled = YES;
    [self cnc_setBackgroundImageWithColor:UIColorGray forObj:cell.subviews[1]];
    if (ISEqualToString(model.title, @"清除缓存")) {
        if (ISEqualToString(model.detail, @"暂无缓存")) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.enabled = NO;
        }
    }else if (ISEqualToString(model.title, @"隐藏准备提交状态的Apps") ||
              ISEqualToString(model.title, @"显示准备提交状态的Apps")) {
        [self cnc_updateWithCell:cell];
    }else {
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    __weak __typeof(self)weakSelf = self;
    CNCSettingModel *model = self.model.models[indexPath.section][indexPath.row];
    if (ISEqualToString(model.title, @"账号管理")) {
        [self.navigationController pushViewController:[CNCAccountManagerController new] animated:YES];
    }else if (ISEqualToString(model.title, @"清除缓存")) {
        [self.toastView showLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.model cnc_clearCacheWithCallBack:^{
                [weakSelf.settingTableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
                [weakSelf.toastView showSucceed:@"缓存清除完成" hideAfterDelay:1.25f];
            }];
        });
    }else if(ISEqualToString(model.title, @"遗忘之城")) {
        if (CNCSQL.ignoreAppModels.count) {
            [self.navigationController pushViewController:[CNCIgnoreAppsController new] animated:YES];
        }else {
            [self.toastView showInfo:@"您当前城中还是一片荒芜\n添加几个住户再来视察吧" hideAfterDelay:2.25f];
        }
    }else if (ISEqualToString(model.title, @"隐藏准备提交状态的Apps") ||
              ISEqualToString(model.title, @"显示准备提交状态的Apps")) {
        [self.model cnc_updateHiddenPrepareForUploadCellWithCallBack:^{
            [weakSelf.settingTableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
}

- (void)cnc_updateWithCell:(CNCSettingCell *)cell {
    cell.backgroundColor = CNCUserDefaultsBoolForKey(kHiddenPrepareForUpload)?QMUICMI.navBarBarTintColor:UIColorWhite;
    cell.textLabel.textColor = CNCUserDefaultsBoolForKey(kHiddenPrepareForUpload)?UIColorWhite:UIColorBlack;
    cell.detailTextLabel.textColor = CNCUserDefaultsBoolForKey(kHiddenPrepareForUpload)?UIColorWhite:UIColorGray;;
    [self cnc_setBackgroundImageWithColor:CNCUserDefaultsBoolForKey(kHiddenPrepareForUpload)?UIColorWhite:UIColorGray forObj:cell.subviews[1]];
}

- (void)cnc_setBackgroundImageWithColor:(UIColor *)color forObj:(id)obj {
    if ([obj isKindOfClass:[UIButton class]]) {
        UIButton *indicator = obj;
        [indicator setBackgroundImage:[UIImage qmui_imageWithShape:QMUIImageShapeDisclosureIndicator size:indicator.currentBackgroundImage.size tintColor:color] forState:UIControlStateNormal];
    }
}

- (CNCSettingView *)settingTableView {
    if (!_settingTableView) {
        _settingTableView = [[CNCSettingView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _settingTableView.dataSource = self;
        _settingTableView.delegate = self;
        _settingTableView.tableHeaderView = [[CNCSettingHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*.3)];
        _settingTableView.sectionHeaderHeight = CGFLOAT_MIN;
        _settingTableView.sectionFooterHeight = 10.f;
    }
    return _settingTableView;
}

- (CNCSettingModel *)model {
    if (!_model) {
        _model = [CNCSettingModel new];
    }
    return _model;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.settingTableView reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
}

@end

