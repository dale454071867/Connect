////  CNCApplicationModel.m
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCApplicationModel.h"
#import "CNCNotification.h"

@interface CNCApplicationModel ()

/** 数据模型 */
@property(nonatomic, copy, readwrite) NSArray<CNCApplicationModel *> *models;

@end

@implementation CNCApplicationModel

- (void)cnc_postAppleDevSiginWithAppleAccountName:(NSString *)accountName password:(NSString *)password {
    __weak __typeof(self)weakSelf = self;
    [CNCNetwork cnc_setSiginRequestHeader];
    [CNCNetwork postUrl:appleDevSiginUrlHost params:@{@"accountName":accountName,
                                                      @"password":password,
                                                      @"rememberMe":@"true"}
               callBack:^(id success) {
                   if ([success[@"authType"] isEqualToString:@"sa"]) {
                       if (weakSelf.cnc_siginCallBack) {
                           weakSelf.cnc_siginCallBack();
                       }
                   }else {
                       [CNCNotification cnc_postNotificationName:kREQUESTERROR object:[NSString stringWithFormat:@"登录失败\n%@", success]];
                   }
               }];
}

- (NSArray<CNCApplicationModel *> *)models {
    if (!_models) {
        _models = [NSArray array];
    }
    return _models;
}

@end
