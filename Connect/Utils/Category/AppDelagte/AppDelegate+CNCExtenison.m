////  AppDelegate+CNCExtenison.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "AppDelegate+CNCExtenison.h"
#import <DWNetworking.h>
#import <IQKeyboardManager.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "CNCTabBarViewController.h"

@implementation AppDelegate (CNCExtenison)

- (void)cnc_applyConfiguration {
    [self networkConfig];
    [self keyboardConfig];
    [self rootViewControllerConfig];
}


- (void)networkConfig {
    [DWNetworking setTimeoutInterval:30.f];
    [DWNetworking setAutoUseCache:NO];
    [DWNetworking setConfigRequestType:DWRequestTypeJSON responseType:DWResponseTypeJSON];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

- (void)keyboardConfig {
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

- (void)rootViewControllerConfig {
    self.window = UIWindow.alloc.init;
    self.window.backgroundColor = UIColor.whiteColor;
    self.window.rootViewController = CNCTabBarViewController.alloc.init;
    [self.window makeKeyAndVisible];
}

@end
