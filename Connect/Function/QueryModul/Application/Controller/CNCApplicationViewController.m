////  CNCApplicationViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCQueryOptionViewController.h"
#import "CNCApplicationViewController.h"
#import "UIImageView+CNCExtension.h"
#import "CNCApplicationModel.h"
#import "CNCApplicationView.h"
#import "CNCApplicationCell.h"
#import "CNCAnimationLabel.h"
#import "CNCAccountModel.h"

@interface CNCApplicationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, QMUINavigationTitleViewDelegate, CNCApplicationCellDelegate>

@property(nonatomic, strong) CNCApplicationView *applicationView;

@property(nonatomic, strong) CNCApplicationCell *currentCell;

@property(nonatomic, strong) CNCApplicationModel *model;

@end

static NSString *const kIdentifier = @"cell";
@implementation CNCApplicationViewController

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
    [self.model cnc_getApplicationStatusWithAccountName:self.accountModel.email password:self.accountModel.developer_password];
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
    cell.lastTime.text = model.lastModifiedDate;
    cell.appVerison1Activity.backgroundColor = UIColorGreen;
    cell.appVersion1.text = @"1";
    cell.appVerison2Activity.backgroundColor = UIColorRed;
    cell.appVersion2.text = @"2";
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView qmui_clearsSelection];
    [self.currentCell cnc_hiddenRemoveCellOption];
    CNCQueryOptionViewController *queryOptions = [[CNCQueryOptionViewController alloc] init];
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

- (void)cnc_applicationDidSelectRemoveCell:(CNCApplicationCell *)cell {
    [cell cnc_hiddenRemoveCellOption];
    QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:@"您是否要隐藏此App" message:@"当您选择隐藏后,下次查询时此App将不会出现在您的App列表中,但是您可以通过设置中的选项来使被隐藏的App再次显示." preferredStyle:QMUIAlertControllerStyleAlert];
    __weak __typeof(self)weakSelf = self;
    [alert addAction:[QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:weakSelf.model.models];
        NSIndexPath *indexPath = [weakSelf.applicationView indexPathForCell:cell];
        [arrM removeObjectAtIndex:indexPath.row];
        [weakSelf.model setValue:arrM forKey:@"models"];
        [weakSelf.applicationView deleteItemsAtIndexPaths:@[indexPath]];
    }]];
    [alert addCancelAction];
    [alert showWithAnimated:YES];
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
