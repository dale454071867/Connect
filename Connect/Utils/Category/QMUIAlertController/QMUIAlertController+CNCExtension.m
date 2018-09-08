////  QMUIAlertController+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/8.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUIAlertController+CNCExtension.h"

@implementation QMUIAlertController (CNCExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementationsInTwoClasses(self, @selector(addCancelAction), self, @selector(cnc_addCancelAction));
    });
}

- (void)cnc_addCancelAction {
    QMUIAlertAction *action = [QMUIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:QMUIAlertActionStyleCancel handler:nil];
    [self addAction:action];
}

@end
