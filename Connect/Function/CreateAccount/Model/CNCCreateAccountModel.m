////  CNCCreateAccountModel.m
//  Connect
//
//  Created by Dwang on 2018/9/5.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCCreateAccountModel.h"

@interface CNCCreateAccountModel ()

@property(nonatomic, copy, readwrite) NSArray <CNCCreateAccountModel *> *models;

/** 标题 */
@property(nonatomic, copy, readwrite) NSString *title;

/** 内容 */
@property(nonatomic, copy, readwrite) NSString *value;

@end

@implementation CNCCreateAccountModel

- (NSArray<CNCCreateAccountModel *> *)models {
    if (!_models) {
        _models = @[
                        [self cnc_modelWithValues:@[NSLocalizedString(@"email", nil), @"email"]],
                        [self cnc_modelWithValues:@[NSLocalizedString(@"developer_password", nil), @"developer_password"]],
                        [self cnc_modelWithValues:@[NSLocalizedString(@"mark", nil), @"mark"]],
                    ];
    }
    return _models;
}

- (CNCCreateAccountModel *)cnc_modelWithValues:(NSArray <NSString *> *)values {
    CNCCreateAccountModel *model = [CNCCreateAccountModel new];
    NSArray<NSString *>*keys = @[@"title", @"key", @"value"];
    [values enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [model setValue:obj forKey:keys[idx]];
    }];
    return model;
}

@end
