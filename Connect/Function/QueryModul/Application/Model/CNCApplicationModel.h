////  CNCApplicationModel.h
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNCAVersionSetsModel.h"

@interface CNCApplicationModel : NSObject

/** 数据模型 */
@property(nonatomic, copy, readonly) NSArray<CNCApplicationModel *> *models;

/** id */
@property(nonatomic, copy, readonly) NSString *adamId;

/** 名称 */
@property(nonatomic, copy, readonly) NSString *name;

/** SKU */
@property(nonatomic, copy, readonly) NSString *vendorId;

/** bundleId */
@property(nonatomic, copy, readonly) NSString *bundleId;

/** logo */
@property(nonatomic, copy, readonly) NSString *iconUrl;

/** 预订截止日期 */
@property(nonatomic, copy, readonly) NSString *preOrderEndDate;

/** 最后操作时间 */
@property(nonatomic, copy, readonly) NSString *lastModifiedDate;

/** 问题数量 */
@property(nonatomic, copy, readonly) NSString *issuesCount;

/** 版本状态 */
@property(nonatomic, strong, readonly) NSArray<CNCAVersionSetsModel *> *versionSets;

/** 登录成功 */
@property(nonatomic, copy) void (^cnc_queryApplicationStatusCallBack)(void);

/**
 请求登录

 @param accountName 账号
 @param password 密码
 */
- (void)cnc_getApplicationStatusWithAccountName:(NSString *)accountName password:(NSString *)password;

@end
