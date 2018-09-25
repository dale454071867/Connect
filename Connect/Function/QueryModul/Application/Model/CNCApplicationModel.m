////  CNCApplicationModel.m
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCApplicationModel.h"

@interface CNCApplicationModel ()

/** 数据模型 */
@property(nonatomic, copy, readwrite) NSArray<CNCApplicationModel *> *models;

@end

@implementation CNCApplicationModel

- (void)cnc_postAppleDevSiginWithApple {
    [CNCNetwork postUrl:appleDevSiginUrlHost params:@{} callBack:^(id success) {
        
    }];
}

- (NSArray<CNCApplicationModel *> *)models {
    if (!_models) {
        _models = [NSArray array];
    }
    return _models;
}

@end
