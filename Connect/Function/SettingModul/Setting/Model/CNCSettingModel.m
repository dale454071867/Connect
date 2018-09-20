////  CNCSettingModel.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCSettingModel.h"
#import <DWNetworking.h>

@interface CNCSettingModel ()

@property(nonatomic, copy, readwrite) NSArray<NSArray <CNCSettingModel *> *> *models;

@property(nonatomic, copy, readwrite) NSString *title;

@property(nonatomic, copy, readwrite) NSString *detail;

@end

@implementation CNCSettingModel

- (NSArray<NSArray<CNCSettingModel *> *> *)models {
    if (!_models) {
        _models = @[
                    @[
                        [self cnc_modelWithValues:@[@"账号管理", @"增加或删除开发者账号"]],
                        ],
                    @[
                        [self cnc_modelWithValues:@[@"清除缓存", [self cnc_getCacheSize]]],
                        ],
                    @[
                        [self cnc_modelWithValues:@[@"忽略的Apps", @""]],
                        [self cnc_modelWithValues:@[[self cnc_updataHiddenPrepareForUploadCell], @"忽略新建Apps"]],
                        ],
                    ];
    }
    return _models;
}

- (void)cnc_clearCacheWithCallBack:(void(^)(void))callBack {
    [DWNetworking cleanAllCache];
    [self.models[1][0] setValue:[self cnc_getCacheSize] forKey:@"detail"];
    if(callBack) {
        callBack();
    }
}

- (void)cnc_updateHiddenPrepareForUploadCellWithCallBack:(void(^)(void))callBack {
    CNCUserDefaultsWithBoolForKey(!CNCUserDefaultsForKey(kHiddenPrepareForUpload), kHiddenPrepareForUpload);
    [self.models[2][1] setValue:[self cnc_updataHiddenPrepareForUploadCell] forKey:@"title"];
    if (callBack) {
        callBack();
    }
}

- (NSString *)cnc_updataHiddenPrepareForUploadCell {
    NSString *str = !CNCUserDefaultsForKey(kHiddenPrepareForUpload)?@"隐藏等待提交状态的Apps":@"显示等待提交状态的Apps";
    return str;
}

- (NSString *)cnc_getCacheSize {
    NSString *cacheSize = @"";
    CGFloat size = [DWNetworking getCachesSize]-36;
    if (size >= 1024*1024) {
        cacheSize = [NSString stringWithFormat:@"%.fGB", size/(1024*1024)];
    }else if (size > 1024) {
        cacheSize = [NSString stringWithFormat:@"%.fMB", size/1024];
    }else if (size <= 0){
        cacheSize = @"暂无缓存";
    }else {
        cacheSize = [NSString stringWithFormat:@"%.fKB", size];
    }
    return cacheSize;
}

- (CNCSettingModel *)cnc_modelWithValues:(NSArray <NSString *> *)values {
    NSArray <NSString *> *keys = @[@"title", @"detail"];
    CNCSettingModel *model = [CNCSettingModel new];
    [values enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [model setValue:obj forKey:keys[idx]];
    }];
    return model;
}

@end
