////  UIView+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UIView+CNCExtension.h"

@implementation UIView (CNCExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementationsInTwoClasses(self, @selector(initWithFrame:), self, @selector(cnc_initWithFrame:));
    });
}

- (instancetype)cnc_initWithFrame:(CGRect)rect {
    UIView *view = [self cnc_initWithFrame:rect];
    [self loadView];
    return view;
}

- (void)loadView {
}

@end
