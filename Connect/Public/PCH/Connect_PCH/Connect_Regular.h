////  Connect_Regular.h
//  Connect
//
//  Created by Dwang on 2018/9/25.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef Connect_Regular_h
#define Connect_Regular_h

/** 邮箱验证,自己写的第一个正则,记录一下😁😁😁 */
static NSString *const kEMailRegular = @"^\\w+@([A-Za-z0-9]{2,}\\.)+[A-Za-z]{2,}$";

/** cookie分割规则 */
static NSString *const kCookiesSegmentationRegular = @"CoderDwang_Connect_iOS_Segmentation_Regular";

/** 请求地址替换规则,此处需要与<Connect_UrlHost.h>文件中的内容统一 */
static NSString *const kResolutionCenterRepcRegular = @"######";

#endif /* Connect_Regular_h */
