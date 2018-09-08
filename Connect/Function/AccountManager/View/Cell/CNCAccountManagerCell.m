

////  CNCAccountManagerCell.m
//  Connect
//
//  Created by Dwang on 2018/9/8.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCAccountManagerCell.h"

@implementation CNCAccountManagerCell

- (void)setCellINFO {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.emailLabel = [[QMUILabel alloc] init];
    [self.contentView addSubview:self.emailLabel];
    [self.emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(5);
    }];
    
    self.lastTimeLabel = [[QMUILabel alloc] init];
    self.lastTimeLabel.font = UIFontMake(14.f);
    self.lastTimeLabel.textColor = UIColorGray;
    [self.contentView addSubview:self.lastTimeLabel];
    [self.lastTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.bottomMargin.offset(-5);
    }];
    
}

@end
