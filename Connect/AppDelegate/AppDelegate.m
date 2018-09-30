////  AppDelegate.m
//  Connect
//
//  Created by Dwang on 2018/8/31.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+CNCExtenison.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self cnc_applyConfigurationWithOptions:launchOptions];
    return YES;
}

@end
