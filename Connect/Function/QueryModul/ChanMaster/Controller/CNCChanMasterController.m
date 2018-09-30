////  CNCChanMasterController.m
//  Connect
//
//  Created by Dwang on 2018/9/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCChanMasterController.h"
#import "CNCQCLoginController.h"
#import "CNCWebView.h"

@interface CNCChanMasterController ()

@property(nonatomic, strong) CNCWebView *webView;

@end

@implementation CNCChanMasterController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"蝉大师";
}

- (void)setUI {
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (CNCWebView *)webView {
    if (!_webView) {
        _webView = [[CNCWebView alloc] initWithRequestURLString:@"https://www.chandashi.com"];
    }
    return _webView;
}

@end
