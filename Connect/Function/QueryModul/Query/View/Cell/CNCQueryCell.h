////  CNCQueryCell.h
//  Connect
//
//  Created by Dwang on 2018/9/10.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUITableViewCell.h"

@interface CNCQueryCell : QMUITableViewCell

/** 开发者账号 */
@property(nonatomic, strong) QMUILabel *emailLabel;

/** 备注 */
@property(nonatomic, strong) QMUILabel *markLabel;

@end
