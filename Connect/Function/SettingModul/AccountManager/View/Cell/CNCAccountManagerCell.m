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
    self.emailLabel.font = CNCAmericanTypewriterBold;
    [self.contentView addSubview:self.emailLabel];
    [self.emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
    }];

    self.markLabel = [[QMUILabel alloc] init];
    self.markLabel.font = UIFontMake(16.f);
    self.markLabel.textColor = UIColorGray;
    [self.contentView addSubview:self.markLabel];
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emailLabel);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.right.equalTo(self.emailLabel);
    }];
    
}

@end
