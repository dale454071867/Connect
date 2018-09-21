////  CNCQueryOptionsModel.m
//  Connect
//
//  Created by Dwang on 2018/9/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCQueryOptionsModel.h"

@interface CNCQueryOptionsModel ()

/** 模型 */
@property(nonatomic, copy, readwrite) NSArray<CNCQueryOptionsModel *> *models;

/** 标题 */
@property(nonatomic, copy, readwrite) NSString *title;

@end

@implementation CNCQueryOptionsModel

- (NSArray <CNCQueryOptionsModel *>*)models {
    if (!_models) {
        _models = @[
                    [self cnc_modelWithValues:@[@"查看详情"]],
                    [self cnc_modelWithValues:@[@"反馈信息"]],
                    [self cnc_modelWithValues:@[@"AppStore"]],
                    [self cnc_modelWithValues:@[@"蝉大师"]],
                    [self cnc_modelWithValues:@[@"七麦数据"]],
                    ];
    }
    return _models;
}

- (CNCQueryOptionsModel *)cnc_modelWithValues:(NSArray <NSString *> *)values {
    CNCQueryOptionsModel *model = [[CNCQueryOptionsModel alloc] init];
    NSArray <NSString *>*keys = @[@"title"];
    [values enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [model setValue:obj forKey:keys[idx]];
    }];
    return model;
}

@end
