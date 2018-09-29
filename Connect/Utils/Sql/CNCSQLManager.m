////  CNCSQLManager.m
//  Connect
//
//  Created by Dwang on 2018/9/3.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//


#import "CNCSQLManager.h"
#import <YTKKeyValueStore.h>
#import <YYModel.h>

@interface CNCSQLManager ()

/** 账号模型数组 */
@property(nonatomic, copy, readwrite) NSArray<CNCAccountModel *> *accountModels;

/** 被忽略的App模型数组 */
@property(nonatomic, copy, readwrite) NSArray<CNCIgnoreAppModel *> *ignoreAppModels;

/** 账号sql对象 */
@property(nonatomic, strong) YTKKeyValueStore *accountStore;

/** 隐藏App的sql对象 */
@property(nonatomic, strong) YTKKeyValueStore *ignoreAppStore;

@end

@implementation CNCSQLManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CNCSQLManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (void)cnc_putToAccountSQLTableWithModel:(CNCAccountModel *)model {
    [self.accountStore putObject:model.yy_modelToJSONObject withId:model.email intoTable:kACCOUNTSQLTABLENAME];
    NSMutableArray<CNCAccountModel *> *arrM = [NSMutableArray arrayWithArray:self.accountModels];
    [arrM insertObject:model atIndex:0];
    self.accountModels = arrM;
    arrM = nil;
}

- (void)cnc_deleteForAccountSQLTableWithModel:(CNCAccountModel *)model {
    [self.accountStore deleteObjectById:model.email fromTable:kACCOUNTSQLTABLENAME];
    NSMutableArray<CNCAccountModel *> *arrM = [NSMutableArray arrayWithArray:self.accountModels];
    [arrM removeObject:model];
    self.accountModels = arrM;
    arrM = nil;
}

- (void)cnc_editForAccountSQLTableWithModel:(CNCAccountModel *)model {
    [self.accountStore putObject:model.yy_modelToJSONObject withId:model.email intoTable:kACCOUNTSQLTABLENAME];
    self.accountModels = nil;
}

- (void)cnc_putToIgnoreAppSQLTableWithModel:(CNCIgnoreAppModel *)model {
    [self.ignoreAppStore putObject:model.yy_modelToJSONObject withId:model.appid intoTable:kIGNOREAPPSQLTABLENAME];
    NSMutableArray<CNCIgnoreAppModel *> *arrM = [NSMutableArray arrayWithArray:self.ignoreAppModels];
    [arrM insertObject:model atIndex:0];
    self.ignoreAppModels = arrM;
    arrM = nil;
}

- (void)cnc_deleteForIgnoreAppSQLTableWithModel:(CNCIgnoreAppModel *)model {
    [self.ignoreAppStore deleteObjectById:model.appid fromTable:kIGNOREAPPSQLTABLENAME];
    NSMutableArray<CNCIgnoreAppModel *> *arrM = [NSMutableArray arrayWithArray:self.ignoreAppModels];
    [arrM removeObject:model];
    self.ignoreAppModels = arrM;
    arrM = nil;
}


- (NSArray<CNCAccountModel *> *)accountModels {
    if (!_accountModels) {
        NSMutableArray<CNCAccountModel *> *tempM = [NSMutableArray array];
        NSArray<YTKKeyValueItem *>*items = [self.accountStore getAllItemsFromTable:kACCOUNTSQLTABLENAME];
        [items enumerateObjectsUsingBlock:^(YTKKeyValueItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tempM insertObject:[CNCAccountModel yy_modelWithJSON:obj.itemObject] atIndex:0];
        }];
        _accountModels = [NSArray arrayWithArray:tempM];
    }
    return _accountModels;
}

- (NSArray<CNCIgnoreAppModel *> *)ignoreAppModels {
    if (!_ignoreAppModels) {
        NSMutableArray<CNCIgnoreAppModel *> *tempM = [NSMutableArray array];
        NSArray<YTKKeyValueItem *>*items = [self.ignoreAppStore getAllItemsFromTable:kIGNOREAPPSQLTABLENAME];
        [items enumerateObjectsUsingBlock:^(YTKKeyValueItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tempM insertObject:[CNCIgnoreAppModel yy_modelWithJSON:obj.itemObject] atIndex:0];
        }];
        _ignoreAppModels = [NSArray arrayWithArray:tempM];
    }
    return _ignoreAppModels;
}

- (YTKKeyValueStore *)accountStore {
    if (!_accountStore) {
        _accountStore = [[YTKKeyValueStore alloc] initDBWithName:kACCOUNTSQLDBNAME];
        [_accountStore createTableWithName:kACCOUNTSQLTABLENAME];
    }
    return _accountStore;
}

- (YTKKeyValueStore *)ignoreAppStore {
    if (!_ignoreAppStore) {
        _ignoreAppStore = [[YTKKeyValueStore alloc] initDBWithName:kIGNOREAPPSQLDBNAME];
        [_ignoreAppStore createTableWithName:kIGNOREAPPSQLTABLENAME];
    }
    return _ignoreAppStore;
}

@end
