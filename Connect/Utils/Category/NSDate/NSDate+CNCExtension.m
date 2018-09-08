////  NSDate+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/8.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "NSDate+CNCExtension.h"

@implementation NSDate (CNCExtension)

+ (NSString *)cnc_currentTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [formatter stringFromDate:date];
}

@end
