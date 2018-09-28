////  CNCApplicationCell.h
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/CoderDwang
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CNCApplicationCell;

@protocol CNCApplicationCellDelegate <NSObject>
@optional

/**
 滑动cell时执行

 @param cell 当前滑动的cell
 */
- (void)cnc_applicationDidScrollCell:(CNCApplicationCell *)cell;

/**
 选择了删除操作

 @param cell 当前操作的cell
 */
- (void)cnc_applicationDidSelectRemoveCell:(CNCApplicationCell *)cell;

@end

@interface CNCApplicationCell : UICollectionViewCell

/** 应用logo */
@property(nonatomic, strong) UIImageView *appIcon;

/** 应用名称 */
@property(nonatomic, strong) QMUILabel *appName;

/** 最后操作时间 */
@property(nonatomic, strong) QMUIButton *lastTime;

/** 应用版本1 */
@property(nonatomic, strong) QMUILabel *appVersion1;

/** 应用版本状态指示器1 */
@property(nonatomic, strong) UIView *appVerison1Activity;

/** 应用版本1按钮 */
@property(nonatomic, strong) QMUIButton *apv1;

/** 应用版本2 */
@property(nonatomic, strong) QMUILabel *appVersion2;

/** 应用版本状态指示器2 */
@property(nonatomic, strong) UIView *appVerison2Activity;

/** 应用版本2按钮 */
@property(nonatomic, strong) QMUIButton *apv2;

/** 忽略/隐藏此App */
@property(nonatomic, strong) QMUIButton *ignore;

/** 获取当前滑动的cell */
@property(nonatomic, weak) id <CNCApplicationCellDelegate> delegate;

/** 隐藏删除按钮 */
- (void)cnc_hiddenRemoveCellOption;

@end
