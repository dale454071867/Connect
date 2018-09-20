////  CNCApplicationCell.m
//  Connect
//
//  Created by Dwang on 2018/9/11.
//    QQ群:    577506623
//    GitHub:    https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCApplicationCell.h"

@interface CNCApplicationCell ()<UIGestureRecognizerDelegate>

@property(nonatomic, strong) UIView *transfromView;

/** 临时存储偏移量 */
@property(nonatomic, assign) CGFloat tx;

@end

@implementation CNCApplicationCell

- (void)setCellINFO {
    
    UIView *selectedBackgroundView = UIView.new;
    selectedBackgroundView.backgroundColor = UIColorMakeWithRGBA(182, 182, 182, 0.4);
    self.selectedBackgroundView = selectedBackgroundView;
    
    self.ignore = [[QMUIButton alloc] init];
    [self.ignore addTarget:self action:@selector(ignoreDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.ignore];
    [self.ignore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.ignore layoutIfNeeded];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.ignore.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)UIColorRed.CGColor,
                       (id)UIColorMakeWithRGBA(255, 0, 0, 0.5).CGColor,
                       (id)[UIColor whiteColor].CGColor, nil];
    gradient.startPoint = CGPointMake(0, 1);
    gradient.endPoint = CGPointMake(1, 1);
    [self.ignore.layer addSublayer:gradient];
    
    self.transfromView = [[UIView alloc] init];
    self.transfromView.backgroundColor = UIColorWhite;
    [self.contentView addSubview:self.transfromView];
    [self.transfromView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    self.backgroundColor = UIColorWhite;
    self.appIcon = [[UIImageView alloc] initWithImage:UIImageMake(@"logo2")];
    [self.transfromView addSubview:self.appIcon];
    [self.appIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.transfromView);
        make.leftMargin.offset(15);
        make.size.equalTo(self.transfromView.mas_height).offset(-10);
    }];
    
    self.appName = [[QMUILabel alloc] init];
    self.appName.font = UIFontMake(16);
    [self.transfromView addSubview:self.appName];
    [self.appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appIcon.mas_top).offset(5);
        make.left.equalTo(self.appIcon.mas_right).offset(10);
    }];
    
    self.lastTime = [[QMUILabel alloc] init];
    self.lastTime.font = UIFontMake(12);
    self.lastTime.textColor = UIColorGrayLighten;
    [self.transfromView addSubview:self.lastTime];
    [self.lastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.appIcon.mas_centerY).offset(2.5);
        make.left.equalTo(self.appName);
    }];
    
    self.appVerison1Activity = [[UIView alloc] init];
    [self.transfromView addSubview:self.appVerison1Activity];
    [self.appVerison1Activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(10);
        make.left.equalTo(self.appName.mas_left);
        make.bottom.equalTo(self.appIcon.mas_bottom).offset(-5);
    }];
    [self cnc_roundWithView:self.appVerison1Activity];
    
    
    self.appVersion1 = [[QMUILabel alloc] init];
    self.appVersion1.textColor = UIColorGray;
    self.appVersion1.font = UIFontMake(12);
    [self.transfromView addSubview:self.appVersion1];
    [self.appVersion1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appVerison1Activity.mas_right).offset(5);
        make.centerY.equalTo(self.appVerison1Activity);
    }];
    
    self.appVerison2Activity = [[UIView alloc] init];
    [self.transfromView addSubview:self.appVerison2Activity];
    [self.appVerison2Activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.appVerison1Activity);
        make.left.equalTo(self.appVersion1.mas_right).offset(20);
        make.centerY.equalTo(self.appVersion1.mas_centerY);
    }];
    [self cnc_roundWithView:self.appVerison2Activity];
    
    self.appVersion2 = [[QMUILabel alloc] init];
    self.appVersion2.textColor = UIColorGray;
    self.appVersion2.font = UIFontMake(12);
    [self.transfromView addSubview:self.appVersion2];
    [self.appVersion2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appVerison2Activity.mas_right).offset(5);
        make.centerY.equalTo(self.appVerison2Activity);
    }];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesterDidPan:)];
    panGesture.delegate = self;
    [self.transfromView addGestureRecognizer:panGesture];
}

- (void)panGesterDidPan:(UIPanGestureRecognizer *)panGesture {
    CGFloat x = [panGesture translationInView:self].x+self.tx;
    __weak __typeof(self)weakSelf = self;
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        self.tx = self.transfromView.transform.tx;
        if (self.delegate && [self.delegate respondsToSelector:@selector(cnc_applicationDidScrollCell:)]) {
            [self.delegate cnc_applicationDidScrollCell:self];
        }
    }else if ((panGesture.state == UIGestureRecognizerStateEnded ||
               panGesture.state == UIGestureRecognizerStateCancelled)
              ) {
        if (x <= -(SCREEN_WIDTH/2)) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(cnc_applicationDidSelectRemoveCell:)]) {
                [self.delegate cnc_applicationDidSelectRemoveCell:self];
            }
        }else if (x <= -100) {
            [weakSelf cnc_changeCellTransform:-100];
        }else {
            [self cnc_hiddenRemoveCellOption];
        }
    }else {
        if (x > 0) {
            [self cnc_hiddenRemoveCellOption];
        }else if (ABS(x) > SCREEN_WIDTH/2) {
            [self cnc_changeCellTransform:-SCREEN_WIDTH];
        }else if(ABS(x) < SCREEN_WIDTH/2) {
            [self cnc_changeCellTransform:x];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)cnc_changeCellTransform:(CGFloat)x {
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:.25f animations:^{
        weakSelf.transfromView.transform = CGAffineTransformMakeTranslation(x, 0);
    }];
}

- (void)cnc_hiddenRemoveCellOption {
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:.25f animations:^{
        weakSelf.transfromView.transform = CGAffineTransformIdentity;
    }];
}

- (void)ignoreDidClick {
    NSLog(@"按钮被点击");
    if (self.delegate && [self.delegate respondsToSelector:@selector(cnc_applicationDidSelectRemoveCell:)]) {
        [self.delegate cnc_applicationDidSelectRemoveCell:self];
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

