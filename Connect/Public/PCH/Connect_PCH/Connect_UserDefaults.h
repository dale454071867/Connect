////  Connect_UserDefaults.h
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef Connect_UserDefaults_h
#define Connect_UserDefaults_h

/** 设置bool值 */
#define CNCUserDefaultsWithBoolForKey(v, k) [[NSUserDefaults standardUserDefaults] setBool:v forKey:k];\
                                            [[NSUserDefaults standardUserDefaults] synchronize];

/** 取出bool值 */
#define CNCUserDefaultsBoolForKey(k) [[NSUserDefaults standardUserDefaults] boolForKey:k]

#endif /* Connect_UserDefaults_h */
