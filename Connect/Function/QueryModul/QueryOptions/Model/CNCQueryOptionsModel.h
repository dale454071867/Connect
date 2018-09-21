////  CNCQueryOptionsModel.h
//  Connect
//
//  Created by Dwang on 2018/9/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCQueryOptionsModel : NSObject

/** 模型 */
@property(nonatomic, copy, readonly) NSArray<CNCQueryOptionsModel *> *models;

/** 标题 */
@property(nonatomic, copy, readonly) NSString *title;

@end

NS_ASSUME_NONNULL_END
