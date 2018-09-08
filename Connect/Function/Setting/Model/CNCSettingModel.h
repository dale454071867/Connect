////  CNCSettingModel.h
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNCSettingModel : NSObject

@property(nonatomic, copy, readonly) NSArray<NSArray <CNCSettingModel *> *> *models;

/** 栏目标题 */
@property(nonatomic, copy, readonly) NSString *title;

/** 详情 */
@property(nonatomic, copy, readonly) NSString *detail;

/** 清空缓存 */
- (void)cnc_clearCacheWithCallBack:(void(^)(void))callBack;

/** 更新是否隐藏准备提交状态的Apps cell状态 */
- (void)cnc_updateHiddenPrepareForUploadCellWithCallBack:(void(^)(void))callBack;

@end
