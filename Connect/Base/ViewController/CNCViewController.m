////  CNCViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCViewController.h"
#import "CNCNotification.h"

@interface CNCViewController ()

@end

@implementation CNCViewController

- (void)didInitialize {
    [super didInitialize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [CNCNotification cnc_addObserver:self selector:@selector(cnc_requestError:) name:kREQUESTERROR];
}

- (void)cnc_requestError:(NSNotification *)cation {
    [self.toastView showError:cation.object];
    [self.toastView hideAnimated:YES afterDelay:2.25f];
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
