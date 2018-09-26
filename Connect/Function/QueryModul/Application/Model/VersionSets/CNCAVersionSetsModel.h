////  CNCAVersionSetsModel.h
//  Connect
//
//  Created by Dwang on 2018/9/26.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNCAVSVersionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CNCAVersionSetsModel : NSObject

/** 平台 */
@property(nonatomic, copy, readonly) NSString *platformString;

/** 在审核的版本 */
@property(nonatomic, strong, readonly) CNCAVSVersionModel *inFlightVersion;

/** 在销售的版本 */
@property(nonatomic, strong, readonly) CNCAVSVersionModel *deliverableVersion;

@end

NS_ASSUME_NONNULL_END
