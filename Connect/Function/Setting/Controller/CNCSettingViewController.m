////  CNCSettingViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//    QQ群:    577506623
//    GitHub:    https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCAccountManagerViewController.h"
#import "CNCIgnoreAppsViewController.h"
#import "CNCSettingViewController.h"
#import "CNCSettingHeaderView.h"
#import "CNCSettingModel.h"
#import "CNCSettingCell.h"

@interface CNCSettingViewController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) QMUITableView *settingTableView;

@property(nonatomic, strong) CNCSettingModel *model;

@end

@implementation CNCSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    [self.view addSubview:self.settingTableView];
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
    if ([model.title isEqualToString:NSLocalizedString(@"clearCache", nil)]) {
        if ([model.detail isEqualToString:NSLocalizedString(@"noCache", nil)]) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.enabled = NO;
        }
    }else if ([model.title isEqualToString:NSLocalizedString(@"hiddenPrepareForUpload", nil)] ||
        [model.title isEqualToString:NSLocalizedString(@"showPrepareForUpload", nil)]) {
        [self cnc_updateWithCell:cell];
    }else {
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    __weak __typeof(self)weakSelf = self;
    CNCSettingModel *model = self.model.models[indexPath.section][indexPath.row];
    if ([model.title isEqualToString:NSLocalizedString(@"accountManager", nil)]) {
        [self.navigationController pushViewController:[CNCAccountManagerViewController new] animated:YES];
    }else if ([model.title isEqualToString:NSLocalizedString(@"clearCache", nil)]) {
        [self.model cnc_clearCacheWithCallBack:^{
            [weakSelf.settingTableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
        }];
    }else if([model.title isEqualToString:NSLocalizedString(@"ignoreApps", nil)]) {
        [self.navigationController pushViewController:[CNCIgnoreAppsViewController new] animated:YES];
    }else if ([model.title isEqualToString:NSLocalizedString(@"hiddenPrepareForUpload", nil)] ||
              [model.title isEqualToString:NSLocalizedString(@"showPrepareForUpload", nil)]) {
        [self.model cnc_updateHiddenPrepareForUploadCellWithCallBack:^{
            [weakSelf.settingTableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
}

- (void)cnc_updateWithCell:(CNCSettingCell *)cell {
    cell.backgroundColor = CNCUserDefaultsForKey(kHiddenPrepareForUpload)?QMUICMI.navBarBarTintColor:UIColorWhite;
    cell.textLabel.textColor = CNCUserDefaultsForKey(kHiddenPrepareForUpload)?UIColorWhite:UIColorBlack;
    cell.detailTextLabel.textColor = CNCUserDefaultsForKey(kHiddenPrepareForUpload)?UIColorWhite:UIColorGray;;
    [self cnc_setBackgroundImageWithColor:CNCUserDefaultsForKey(kHiddenPrepareForUpload)?UIColorWhite:UIColorGray forObj:cell.subviews[1]];
}

- (void)cnc_setBackgroundImageWithColor:(UIColor *)color forObj:(id)obj {
    if ([obj isKindOfClass:[UIButton class]]) {
        UIButton *indicator = obj;
        [indicator setBackgroundImage:[UIImage qmui_imageWithShape:QMUIImageShapeDisclosureIndicator size:indicator.currentBackgroundImage.size tintColor:color] forState:UIControlStateNormal];
    }
}

- (QMUITableView *)settingTableView {
    if (!_settingTableView) {
        _settingTableView = [[QMUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
