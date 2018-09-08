////  CNCSQLManager.h
//  Connect
//
//  Created by Dwang on 2018/9/3.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNCAccountModel.h"

@interface CNCSQLManager : NSObject

+ (instancetype)sharedInstance;

/** 账号模型数组 */
@property(nonatomic, copy, readonly) NSArray<CNCAccountModel *> *accountModels;

/** 忽略App的模型数组 */
//@property(nonatomic, copy, readonly) NSArray *ignoreAppModels;

/**
 添加账号

 @param model 账号模型
 */
- (void)cnc_putToAccountSQLTableWithModel:(CNCAccountModel *)model;

/**
 删除账号

 @param model 账号模型
 */
- (void)cnc_deleteForAccountSQLTableWithModel:(CNCAccountModel *)model;

@end
