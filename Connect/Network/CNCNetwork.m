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

/** 设置开发者中心登录请求头 */
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

/** 设置七麦登录请求头 */
+ (void)cnc_setQiMaiLoginRequestHeader {
    [DWNetworking setHttpHeaderConfig:@{@"Content-Type":@"application/x-www-form-urlencoded; charset=UTF-8",
                                        @"Accept":@"application/json, text/plain, */*",
                                        @"Cookie":@"acw_tc=76b20f4315375092624276384e795afea68a61f16861983b45c2597397c869; PHPSESSID=oog5c5hgfilh24f88v2udjkgp1; Hm_lvt_ff3eefaf44c797b33945945d0de0e370=1537509263; Hm_lpvt_ff3eefaf44c797b33945945d0de0e370=1537509263; Hm_lvt_5743840c765eced6094267d6e69ad21d=1537509302; Hm_lpvt_5743840c765eced6094267d6e69ad21d=1537509302; synct=1537509345.249",
                                        @"Host":@"api.qimai.cn",
                                        @"Origin":@"https://www.qimai.cn",
                                        @"Referer":@"https://www.qimai.cn/account/signin",
                                        @"Connection":@"keep-alive",
                                        @"Accept-Encoding":@"gzip, deflate, br",
                                        @"Accept-Language":@"zh-CN,zh;q=0.9"}];
}

/** 设置开发者中心查询请求头 */
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
