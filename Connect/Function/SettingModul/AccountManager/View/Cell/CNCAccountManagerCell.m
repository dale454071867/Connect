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
        make.leftMargin.offset(15);
        make.topMargin.offset(5);
        make.rightMargin.offset(-5);
    }];

    self.markLabel = [[QMUILabel alloc] init];
    self.markLabel.font = UIFontMake(16.f);
    self.markLabel.textColor = UIColorGray;
    [self.contentView addSubview:self.markLabel];
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emailLabel);
        make.bottomMargin.offset(-5);
        make.right.equalTo(self.emailLabel);
    }];
    
}

@end
