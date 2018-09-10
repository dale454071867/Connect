////  CNCTabBarViewController+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCTabBarViewController+CNCExtension.h"
#import "CNCViewController.h"
#import "CNCNavigationController.h"

@implementation CNCTabBarViewController (CNCExtension)

- (void)cnc_addChildViewController:(CNCViewController *)viewController tabBarImageName:(NSString *)imgName title:(NSString *)title {
    viewController.tabBarItem.image = UIImageMake(imgName);
    viewController.title = title;
    [self addChildViewController:[[CNCNavigationController alloc] initWithRootViewController:viewController]];
}

@end
