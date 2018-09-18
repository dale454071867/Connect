////  Connect_Enum.h
//  Connect
//
//  Created by Dwang on 2018/9/18.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef Connect_Enum_h
#define Connect_Enum_h

/** 账号数据发生改变 */
typedef NS_ENUM(NSUInteger, CNCAccountOperateType) {
    /** 新增账号 */
    CNCAccountOperateTypeCreate,
    /** 账号信息修改 */
    CNCAccountOperateTypeEdit,
};

#endif /* Connect_Enum_h */
