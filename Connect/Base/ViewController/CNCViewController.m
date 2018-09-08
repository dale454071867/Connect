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
    // Do any additional setup after loading the view.
}

- (void)dealloc
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
