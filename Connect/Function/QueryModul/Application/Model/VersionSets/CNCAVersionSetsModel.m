////  CNCAVersionSetsModel.m
//  Connect
//
//  Created by Dwang on 2018/9/26.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCAVersionSetsModel.h"
#import <YYModel.h>

@interface CNCAVersionSetsModel ()

/** 平台 */
@property(nonatomic, copy, readwrite) NSString *platformString;

/** 在审核的版本 */
@property(nonatomic, strong, readwrite) CNCAVSVersionModel *inFlightVersion;

/** 在销售的版本 */
@property(nonatomic, strong, readwrite) CNCAVSVersionModel *deliverableVersion;

@property(nonatomic, copy, readwrite) NSString *type;

@property(nonatomic, assign, readwrite) BOOL everBeenOnSale;

@end

@implementation CNCAVersionSetsModel

@end
