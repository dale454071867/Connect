////  CNCAVersionSetsModel.m
//  Connect
//
//  Created by Dwang on 2018/9/26.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCAVersionSetsModel.h"

@interface CNCAVersionSetsModel ()

/** 平台 */
@property(nonatomic, copy, readwrite) NSString *platformString;

/** 在审核的版本 */
@property(nonatomic, strong, readwrite) CNCAVSVersionModel *inFlightVersion;

/** 在销售的版本 */
@property(nonatomic, strong, readwrite) CNCAVSVersionModel *deliverableVersion;


@end

@implementation CNCAVersionSetsModel

@end
