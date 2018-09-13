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

@interface CNCApplicationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) CNCApplicationView *applicationView;

@end

static NSString *const kIdentifier = @"cell";
@implementation CNCApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"应用列表";
    self.titleView.subtitle = self.accountModel.email;
    self.titleView.style = QMUINavigationTitleViewStyleSubTitleVertical;
    
}

- (void)setUI {
    [self.view addSubview:self.applicationView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CNCApplicationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    
    
    return cell;
}

- (CNCApplicationView *)applicationView {
    if (!_applicationView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _applicationView = [[CNCApplicationView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_applicationView registerClass:[CNCApplicationCell class] forCellWithReuseIdentifier:kIdentifier];
        _applicationView.dataSource = self;
        _applicationView.delegate = self;
    }
    return _applicationView;
}


@end
