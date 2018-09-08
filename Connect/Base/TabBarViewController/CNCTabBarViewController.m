////  CNCTabBarViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCTabBarViewController.h"
#import "CNCSettingViewController.h"
#import "CNCTabBarViewController+CNCExtension.h"

@interface CNCTabBarViewController ()

@end

@implementation CNCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cnc_addChildViewController:CNCSettingViewController.new tabBarImageName:@"设置" title:@"settingTitle"];
}

@end