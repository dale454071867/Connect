////  CNCApplicationController.h
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCViewController.h"
@class CNCAccountModel;

@interface CNCApplicationController : CNCViewController

/** 账号模型 */
@property(nonatomic, strong) CNCAccountModel *accountModel;

/** 当前账号在数据库中的位置 */
@property(nonatomic, assign) NSInteger index;

@end
