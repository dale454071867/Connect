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
#import <YYModel.h>

@interface CNCApplicationModel ()

/** 数据模型 */
@property(nonatomic, copy, readwrite) NSArray<CNCApplicationModel *> *models;

/** id */
@property(nonatomic, copy, readwrite) NSString *adamId;

/** 名称 */
@property(nonatomic, copy, readwrite) NSString *name;

/** SKU */
@property(nonatomic, copy, readwrite) NSString *vendorId;

/** bundleId */
@property(nonatomic, copy, readwrite) NSString *bundleId;

/** logo */
@property(nonatomic, copy, readwrite) NSString *iconUrl;

/** 预订截止日期 */
@property(nonatomic, copy, readwrite) NSString *preOrderEndDate;

/** 最后操作时间 */
@property(nonatomic, copy, readwrite) NSString *lastModifiedDate;

/** 问题数量 */
@property(nonatomic, copy, readwrite) NSString *issuesCount;

/** 版本状态 */
@property(nonatomic, strong, readwrite) NSArray<CNCAVersionSetsModel *> *versionSets;

@end

@implementation CNCApplicationModel

- (void)cnc_getApplicationStatusWithAccountName:(NSString *)accountName password:(NSString *)password {
    __weak __typeof(self)weakSelf = self;
    [CNCNetwork cnc_setAppleDevSiginHeader];
    [CNCNetwork postUrl:appleDevSiginUrlHost params:@{@"accountName":accountName,
                                                      @"password":password,
                                                      @"rememberMe":@"true"}
               callBack:^(id success) {
                   if ([success[@"authType"] isEqualToString:@"sa"]) {
                       [weakSelf cnc_getAppleApplicationStatus];
                   }else {
                       [CNCNotification cnc_postNotificationName:kREQUESTERROR object:[NSString stringWithFormat:@"登录失败\n%@", success]];
                   }
               }];
}

- (void)cnc_getAppleApplicationStatus {
    __weak __typeof(self)weakSelf = self;
    [CNCNetwork cnc_setQueryApplicationStatusHeaderHeader];
    [CNCNetwork getUrl:appleApplicationStatusUrlHost callBack:^(id success) {
        if ([success[@"statusCode"] isEqualToString:@"SUCCESS"]) {
            weakSelf.models = [NSArray yy_modelArrayWithClass:[CNCApplicationModel class] json:success[@"data"][@"summaries"]];
            if (weakSelf.cnc_queryApplicationStatusCallBack) {
                weakSelf.cnc_queryApplicationStatusCallBack();
            }
        }else {
            [CNCNotification cnc_postNotificationName:kREQUESTERROR object:[NSString stringWithFormat:@"查询失败\n%@", success]];
        }
    }];
}

- (NSString *)lastModifiedDate {
    NSTimeInterval interval = [_lastModifiedDate doubleValue]/1000.0;
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *creat = [NSDate dateWithTimeIntervalSince1970:interval];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *compas = [calendar components:unit fromDate:creat toDate:nowDate options:0];
    if (compas.year) {
        return [NSString stringWithFormat:@"%ld years ago", (long)compas.year];
    }else if (compas.month) {
        return [NSString stringWithFormat:@"%ld months ago", (long)compas.month];
    }else if (compas.day) {
        return [NSString stringWithFormat:@"%ld days ago", (long)compas.day];
    }else if (compas.hour) {
        return [NSString stringWithFormat:@"%ld hours ago", (long)compas.hour];
    }else if (compas.minute) {
        return [NSString stringWithFormat:@"%ld minutes ago", (long)compas.minute];
    }
    return @"刚刚";
}

- (NSArray<CNCApplicationModel *> *)models {
    if (!_models) {
        _models = [NSArray array];
    }
    return _models;
}

@end
