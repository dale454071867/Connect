////  CNCNetwork.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCNetwork.h"
#import <DWNetworking.h>

@implementation CNCNetwork

/** 设置登录请求头 */
+ (void)cnc_setLoginRequestHeader {
    [DWNetworking setHttpHeaderConfig:@{@"Accept":@"application/json, text/javascript, */*; q=0.01",
                                        @"Accept-Encoding":@"gzip, deflate, br",
                                        @"Accept-Language":@"zh-CN,zh;q=0.9",
                                        @"Connection":@"keep-alive",
                                        @"Content-Type":@"application/json",
                                        @"Host":@"idmsa.apple.com",
                                        @"Origin":@"https://idmsa.apple.com",
                                        @"Referer":@"https://idmsa.apple.com/appleauth/auth/signin?widgetKey=e0b80c3bf78523bfe80974d320935bfa30add02e1bff88ec2166c6bd5a706c42&widgetDomain=https://itunesconnect.apple.com:443&font=sf",
                                        @"X-Apple-Widget-Key":@"e0b80c3bf78523bfe80974d320935bfa30add02e1bff88ec2166c6bd5a706c42",
                                        @"X-Requested-With":@"XMLHttpRequest",
                                        }];
}

/** 设置查询请求头 */
+ (void)cnc_setQueryReuqestHeader {
    [DWNetworking setHttpHeaderConfig:@{@"Accept":@"application/json, text/javascript, */*; q=0.01",
                                        @"Accept-Encoding":@"gzip, deflate, br",
                                        @"Accept-Language":@"zh-CN,zh;q=0.9",
                                        @"Connection":@"keep-alive",
                                        @"Host":@"itunesconnect.apple.com",
                                        @"Referer":@"https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app"
                                        }];
}

/** POST */
+ (void)postUrl:(NSString *)url params:(NSDictionary *)params callBack:(void(^)(id success))callBack {
    [DWNetworking postUrlString:url params:params resultCallBack:^(id success, NSError *error, BOOL isCache) {
        if (error) {
            [self cnc_requestError:error];
        }else {
            callBack(success);
        }
    }];
}

/** GET */
+ (void)getUrl:(NSString *)url callBack:(void(^)(id success))callBack {
    [DWNetworking getUrlString:url params:nil resultCallBack:^(id success, NSError *error, BOOL isCache) {
        if (error) {
            [self cnc_requestError:error];
        }else {
            callBack(success);
        }
    }];
}

/** 请求失败 */
+ (void)cnc_requestError:(NSError *)error {
    
}

@end
