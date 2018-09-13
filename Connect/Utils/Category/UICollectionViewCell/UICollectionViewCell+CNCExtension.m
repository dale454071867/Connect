////  UICollectionViewCell+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UICollectionViewCell+CNCExtension.h"

@implementation UICollectionViewCell (CNCExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(initWithFrame:), @selector(cnc_cell_initWithFrame:));
    });
}

- (instancetype)cnc_cell_initWithFrame:(CGRect)frame {
    UICollectionViewCell *cell = [self cnc_cell_initWithFrame:frame];
    [self setCellINFO];
    return cell;
}

- (void)setCellINFO {
}

@end
