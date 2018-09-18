////  CNCApplicationViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCApplicationViewController.h"
#import "CNCApplicationModel.h"
#import "CNCApplicationView.h"
#import "CNCApplicationCell.h"
#import "CNCAccountModel.h"

@interface CNCApplicationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, QMUINavigationTitleViewDelegate, CNCApplicationCellDelegate>

@property(nonatomic, strong) CNCApplicationView *applicationView;

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

- (void)didTouchTitleView:(QMUINavigationTitleView *)titleView isActive:(BOOL)isActive {
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CNCApplicationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    cell.appName.text = @"测试名称";
    cell.lastTime.text = @"17小时前";
    cell.appVerison1Activity.backgroundColor = UIColorGreen;
    cell.appVersion1.text = @"1.0.1";
    cell.appVerison2Activity.backgroundColor = UIColorRed;
    cell.appVersion2.text = @"1.0.2";
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView qmui_clearsSelection];
}

- (void)cnc_applicationCell:(CNCApplicationCell *)cell state:(CNCApplicationCellState)state point:(CGPoint)point {
    NSLog(@"%@", NSStringFromCGPoint(point));
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


@end
