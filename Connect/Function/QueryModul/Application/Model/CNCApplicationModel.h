////  CNCApplicationModel.h
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNCApplicationModel : NSObject

/** 数据模型 */
@property(nonatomic, copy, readonly) NSArray<CNCApplicationModel *> *models;

/** 登录成功 */
@property(nonatomic, copy) void (^cnc_siginCallBack)(void);

/**
 请求登录

 @param accountName 账号
 @param password 密码
 */
- (void)cnc_postAppleDevSiginWithAppleAccountName:(NSString *)accountName password:(NSString *)password;

@end
