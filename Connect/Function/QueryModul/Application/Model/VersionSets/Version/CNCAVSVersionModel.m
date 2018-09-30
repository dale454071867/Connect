////  CNCAVSVersionModel.m
//  Connect
//
//  Created by Dwang on 2018/9/26.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCAVSVersionModel.h"

@interface CNCAVSVersionModel ()

/** 类型 */
@property(nonatomic, copy, readwrite) NSString *type;

/** 版本 */
@property(nonatomic, copy, readwrite) NSString *version;

/** 状态 */
@property(nonatomic, copy, readwrite) NSString *state;

/** 状态key */
@property(nonatomic, copy, readwrite) NSString *stateKey;

/** 状态分组 */
@property(nonatomic, copy, readwrite) NSString *stateGroup;

/** 状态颜色 */
@property(nonatomic, strong, readwrite) UIColor *stateColor;

/** 状态中文 */
@property(nonatomic, copy, readwrite) NSString *stateStr;

@end

@implementation CNCAVSVersionModel

- (NSString *)stateStr {
    if (ISEqualToString(_state, @"inReview")) {
        return @"正在审核";
    }else if (ISEqualToString(_state, @"waitingForReview")) {
        return @"等待审核";
    }else if (ISEqualToString(_state, @"prepareForUpload")) {
        return @"准备提交";
    }else if (ISEqualToString(_state, @"devRejected")) {
        return @"被开发人员拒绝";
    }else if (ISEqualToString(_state, @"rejected")) {
        return @"二进制文件被拒绝";
    }else if (ISEqualToString(_state, @"metadataRejected")) {
        return @"元数据被拒绝";
    }else if (ISEqualToString(_state, @"removedFromSale")) {
        return @"已下架";
    }else if (ISEqualToString(_state, @"readyForSale")) {
        return @"可供销售";
    }else if (ISEqualToString(_state, @"pendingDeveloperRelease")) {
        return @"等待开发人员发布";
    }
    return _state;
}

- (UIColor *)stateColor {
    if (ISEqualToString(_state, @"inReview") ||
        ISEqualToString(_state, @"waitingForReview") ||
        ISEqualToString(_state, @"prepareForUpload")) {
        return UIColorMake(255, 207, 71);
    }else if (ISEqualToString(_state, @"devRejected") ||
              ISEqualToString(_state, @"rejected") ||
              ISEqualToString(_state, @"metadataRejected") ||
              ISEqualToString(_state, @"removedFromSale")) {
        return UIColorRed;
    }else if (ISEqualToString(_state, @"readyForSale")) {
        return UIColorMake(159, 214, 97);
    }
    return [UIColor qmui_randomColor];
}

@end
