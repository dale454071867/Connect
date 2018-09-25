////  CNCViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCViewController.h"

@interface CNCViewController ()

@end

@implementation CNCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (QMUIToastView *)toastView {
    if (!_toastView) {
        _toastView = [[QMUITips alloc] initWithView:self.view];
        [self.view addSubview:_toastView];
    }
    return _toastView;
}

- (void)dealloc
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
