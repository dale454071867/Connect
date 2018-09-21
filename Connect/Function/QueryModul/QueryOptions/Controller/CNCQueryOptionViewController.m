////  CNCQueryOptionViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCQueryOptionViewController.h"
#import "CNCQueryOptionsModel.h"
#import "CNCQueryOptionsCell.h"
#import "CNCQueryOptionView.h"
#import "CNCAnimationLabel.h"

static NSString *const kIdentifier = @"cell";
@interface CNCQueryOptionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) CNCQueryOptionView *queryOptionView;

@property(nonatomic, strong) CNCQueryOptionsModel *model;

@end

@implementation CNCQueryOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"操作类型";
}

- (void)setUI {
    [self.view addSubview:self.queryOptionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CNCQueryOptionsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    cell.title.text = self.model.models[indexPath.row].title;
    return cell;
}

- (CNCQueryOptionView *)queryOptionView {
    if (!_queryOptionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH-15, SCREEN_WIDTH*.28);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = CGFLOAT_MIN;
        _queryOptionView = [[CNCQueryOptionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _queryOptionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _queryOptionView.showsVerticalScrollIndicator = NO;
        _queryOptionView.dataSource = self;
        _queryOptionView.delegate = self;
        _queryOptionView.alwaysBounceVertical = YES;
        _queryOptionView.contentInset = UIEdgeInsetsMake(10, 0, 25, 0);
        [_queryOptionView registerClass:[CNCQueryOptionsCell class] forCellWithReuseIdentifier:kIdentifier];
    }
    return _queryOptionView;
}

- (CNCQueryOptionsModel *)model {
    if (!_model) {
        _model = [[CNCQueryOptionsModel alloc] init];
    }
    return _model;
}

@end
