////  CNCApplicationCell.m
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCApplicationCell.h"

@implementation CNCApplicationCell

- (void)setCellINFO {
    
    UIView *selectedBackgroundView = UIView.new;
    selectedBackgroundView.backgroundColor = UIColorMakeWithRGBA(182, 182, 182, 0.4);
    self.selectedBackgroundView = selectedBackgroundView;
    
    self.backgroundColor = UIColorWhite;
    self.appIcon = [[UIImageView alloc] initWithImage:UIImageMake(@"logo2")];
    [self.contentView addSubview:self.appIcon];
    [self.appIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.leftMargin.offset(15);
        make.size.equalTo(self.contentView.mas_height).offset(-10);
    }];
    
    self.appName = [[QMUILabel alloc] init];
    self.appName.font = UIFontMake(16);
    [self.contentView addSubview:self.appName];
    [self.appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appIcon.mas_top).offset(5);
        make.left.equalTo(self.appIcon.mas_right).offset(10);
    }];
    
    self.lastTime = [[QMUILabel alloc] init];
    self.lastTime.font = UIFontMake(12);
    self.lastTime.textColor = UIColorGrayLighten;
    [self.contentView addSubview:self.lastTime];
    [self.lastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.appIcon.mas_centerY).offset(2.5);
        make.left.equalTo(self.appName);
    }];
    
    self.appVerison1Activity = [[UIView alloc] init];
    [self.contentView addSubview:self.appVerison1Activity];
    [self.appVerison1Activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(10);
        make.left.equalTo(self.appName.mas_left);
        make.bottom.equalTo(self.appIcon.mas_bottom).offset(-5);
    }];
    [self cnc_roundWithView:self.appVerison1Activity];
    
    
    self.appVersion1 = [[QMUILabel alloc] init];
    self.appVersion1.textColor = UIColorGray;
    self.appVersion1.font = UIFontMake(12);
    [self.contentView addSubview:self.appVersion1];
    [self.appVersion1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appVerison1Activity.mas_right).offset(5);
        make.centerY.equalTo(self.appVerison1Activity);
    }];
    
    self.appVerison2Activity = [[UIView alloc] init];
    [self.contentView addSubview:self.appVerison2Activity];
    [self.appVerison2Activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.appVerison1Activity);
        make.left.equalTo(self.appVersion1.mas_right).offset(20);
        make.centerY.equalTo(self.appVersion1.mas_centerY);
    }];
    [self cnc_roundWithView:self.appVerison2Activity];
    
    self.appVersion2 = [[QMUILabel alloc] init];
    self.appVersion2.textColor = UIColorGray;
    self.appVersion2.font = UIFontMake(12);
    [self.contentView addSubview:self.appVersion2];
    [self.appVersion2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appVerison2Activity.mas_right).offset(5);
        make.centerY.equalTo(self.appVerison2Activity);
    }];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesterDidPan:)];
    [self addGestureRecognizer:panGesture];
}

- (void)panGesterDidPan:(UIPanGestureRecognizer *)panGesture {
    if (self.delegate && [((id)self.delegate) respondsToSelector:@selector(cnc_applicationCell:state:point:)]) {
        [self.delegate cnc_applicationCell:self state:(NSInteger)panGesture.state point:[panGesture translationInView:self]];
    }
}

- (void)cnc_roundWithView:(UIView *)view {
    [view layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:view.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

@end
