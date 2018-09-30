////  CNCApplicationController.m
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCQueryOptionsController.h"
#import "CNCApplicationController.h"
#import "UIImageView+CNCExtension.h"
#import "CNCApplicationModel.h"
#import "NSDate+CNCExtension.h"
#import "CNCApplicationView.h"
#import "CNCApplicationCell.h"
#import "CNCAnimationLabel.h"
#import "CNCSQLManager.h"


@interface CNCApplicationController ()<UICollectionViewDelegate, UICollectionViewDataSource, QMUINavigationTitleViewDelegate, CNCApplicationCellDelegate>

@property(nonatomic, strong) CNCApplicationView *applicationView;

@property(nonatomic, strong) CNCApplicationCell *currentCell;

@property(nonatomic, strong) CNCApplicationModel *model;

@property(nonatomic, strong) QMUIPopupContainerView *popupContainerView;

@end

static NSString *const kIdentifier = @"cell";
@implementation CNCApplicationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"应用程序";
    self.titleView.delegate = self;
    self.titleView.userInteractionEnabled = YES;
    self.titleView.subtitle = self.accountModel.email;
    self.titleView.verticalTitleFont = UIFontMake(18);
    self.titleView.verticalSubtitleFont = UIFontMake(12);
    self.titleView.style = QMUINavigationTitleViewStyleSubTitleVertical;
    self.titleView.accessoryType = QMUINavigationTitleViewAccessoryTypeDisclosureIndicator;
}

- (void)setUI {
    [self.view addSubview:self.applicationView];
}

- (void)setNetwork {
    [self.toastView showLoading];
    __weak __typeof(self)weakSelf = self;
    [self.model cnc_getApplicationStatusWithAccountModel:self.accountModel index:self.index];
    self.model.cnc_queryApplicationStatusCallBack = ^{
        [weakSelf.toastView hideAnimated:YES];
        [weakSelf.applicationView reloadData];
    };
}

- (void)didTouchTitleView:(QMUINavigationTitleView *)titleView isActive:(BOOL)isActive {
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.models.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CNCApplicationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    CNCApplicationModel *model = self.model.models[indexPath.row];
    cell.appIcon.activity = model.iconUrl;
    cell.appName.text = model.name;
    [cell.lastTime setTitle:model.lastModifiedFifferenceDate forState:UIControlStateNormal];
    cell.lastTime.tag = indexPath.row;
    [cell.lastTime addTarget:self action:@selector(cnc_lastTimeDidClick:) forControlEvents:UIControlEventTouchUpInside];
    CNCAVersionSetsModel *setsModel = model.versionSets[0];
    if (setsModel.deliverableVersion.state.length) {
        cell.appVerison1Activity.backgroundColor = setsModel.deliverableVersion.stateColor;
        cell.appVersion1.text = setsModel.deliverableVersion.version;
        if (setsModel.inFlightVersion.state.length) {
            cell.appVerison2Activity.backgroundColor = setsModel.inFlightVersion.stateColor;
            cell.appVersion2.text = setsModel.inFlightVersion.version;
        }
    }else {
        cell.appVerison1Activity.backgroundColor = setsModel.inFlightVersion.stateColor;
        cell.appVersion1.text = setsModel.inFlightVersion.version;
    }
    cell.apv1.tag = indexPath.row;
    cell.apv2.tag = indexPath.row;
    [cell.apv1 addTarget:self action:@selector(cnc_apv1DidClick:) forControlEvents:UIControlEventTouchUpInside];
    if (cell.appVersion2.text.isNotBlank) {
        [cell.apv2 addTarget:self action:@selector(cnc_apv2DidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView qmui_clearsSelection];
    [self.currentCell cnc_hiddenRemoveCellOption];
    CNCQueryOptionsController *queryOptions = [[CNCQueryOptionsController alloc] init];
    [self.navigationController pushViewController:queryOptions animated:YES];
}

- (void)cnc_applicationDidScrollCell:(CNCApplicationCell *)cell {
    if (self.currentCell) {
        [self.currentCell cnc_hiddenRemoveCellOption];
        self.currentCell = cell;
    }else if (!self.currentCell) {
        self.currentCell = cell;
    }
}

- (void)cnc_lastTimeDidClick:(QMUIButton *)sender {
    CNCApplicationModel *model = self.model.models[sender.tag];
    self.popupContainerView.textLabel.text = model.lastModifiedFormatDate;
    [self.popupContainerView layoutWithTargetView:sender];
    [self.popupContainerView showWithAnimated:YES];
}

- (void)cnc_apv1DidClick:(QMUIButton *)sender {
    CNCApplicationModel *model = self.model.models[sender.tag];
    NSString *state = model.versionSets[0].deliverableVersion.state;
    if (state.length) {
        NSString *message = @"";
        if (ISEqualToString(state, @"inReview") ||
            ISEqualToString(state, @"waitingForReview") ||
            ISEqualToString(state, @"readyForSale") ||
            ISEqualToString(state, @"pendingDeveloperRelease")) {
            message = [NSString stringWithFormat:@"版本号:%@\n当前状态:%@",
                       model.versionSets[0].deliverableVersion.version,
                       model.versionSets[0].deliverableVersion.stateStr];
        }else {
            message = [NSString stringWithFormat:@"版本号:%@\n问题数:%@\n当前状态:%@",
                       model.versionSets[0].deliverableVersion.version,
                       model.issuesCount,
                       model.versionSets[0].deliverableVersion.stateStr];
        }
        self.popupContainerView.textLabel.text = message;
        [self.popupContainerView layoutWithTargetView:sender];
        [self.popupContainerView showWithAnimated:YES];
    }else{
        [self cnc_apv2DidClick:sender];
    }
}

- (void)cnc_apv2DidClick:(QMUIButton *)sender {
    CNCApplicationModel *model = self.model.models[sender.tag];
    self.popupContainerView.textLabel.text = [NSString stringWithFormat:@"版本号:%@\n问题数:%@\n当前状态:%@",
                                              model.versionSets[0].inFlightVersion.version,
                                              model.issuesCount,
                                              model.versionSets[0].inFlightVersion.stateStr];
    [self.popupContainerView layoutWithTargetView:sender];
    [self.popupContainerView showWithAnimated:YES];
}

- (void)cnc_applicationDidSelectRemoveCell:(CNCApplicationCell *)cell {
    [cell cnc_hiddenRemoveCellOption];
    QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:@"您是否要隐藏此App" message:@"当您选择隐藏后,下次查询时此App将不会出现在您的App列表中,但是您可以通过设置中的选项来使被隐藏的App再次显示." preferredStyle:QMUIAlertControllerStyleAlert];
    __weak __typeof(self)weakSelf = self;
    [alert addAction:[QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action)
    {
        NSIndexPath *indexPath = [weakSelf.applicationView indexPathForCell:cell];
        CNCApplicationModel *aModel = weakSelf.model.models[indexPath.row];
        CNCIgnoreAppModel *imodel = [[CNCIgnoreAppModel alloc] init];
        [imodel setValue:[NSDate cnc_currentDateWithFormat:@"YYYY-MM-dd hh:mm"] forKey:@"creatTime"];
        [imodel setValue:aModel.adamId forKey:@"appid"];
        [imodel setValue:[UIImageJPEGRepresentation(cell.appIcon.image, 1.f) base64EncodedString] forKey:@"appIcon"];
        [imodel setValue:aModel.name forKey:@"appName"];
        [imodel setValue:weakSelf.accountModel.email forKey:@"account"];
        [CNCSQL cnc_putToIgnoreAppSQLTableWithModel:imodel];
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:weakSelf.model.models];
        [arrM removeObjectAtIndex:indexPath.row];
        [weakSelf.model setValue:arrM forKey:@"models"];
        [weakSelf.applicationView deleteItemsAtIndexPaths:@[indexPath]];
    }]];
    [alert addCancelAction];
    [alert showWithAnimated:YES];
}

- (QMUIPopupContainerView *)popupContainerView {
    if (!_popupContainerView) {
        _popupContainerView = [[QMUIPopupContainerView alloc] init];
        _popupContainerView.automaticallyHidesWhenUserTap = YES;
    }
    return _popupContainerView;
}

- (CNCApplicationView *)applicationView {
    if (!_applicationView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.view.width, 84);
        layout.minimumInteritemSpacing = CGFLOAT_MIN;
        layout.minimumLineSpacing = 1.f;
        _applicationView = [[CNCApplicationView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _applicationView.alwaysBounceVertical = YES;
        [_applicationView registerClass:[CNCApplicationCell class] forCellWithReuseIdentifier:kIdentifier];
        _applicationView.dataSource = self;
        _applicationView.delegate = self;
    }
    return _applicationView;
}

- (CNCApplicationModel *)model {
    if (!_model) {
        _model = [[CNCApplicationModel alloc] init];
    }
    return _model;
}

@end
