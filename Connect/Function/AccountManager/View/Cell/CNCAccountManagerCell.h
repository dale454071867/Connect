////  CNCAccountManagerCell.h
//  Connect
//
//  Created by Dwang on 2018/9/8.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUITableViewCell.h"

@interface CNCAccountManagerCell : QMUITableViewCell

/** 邮箱 */
@property(nonatomic, strong) QMUILabel *emailLabel;

/** 备注 */
@property(nonatomic, strong) QMUILabel *markLabel;

/** 最后修改时间 */
@property(nonatomic, strong) QMUILabel *lastTimeLabel;

@end
