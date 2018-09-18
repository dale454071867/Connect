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

typedef NS_ENUM(NSUInteger, CNCApplicationCellState) {
    /** 识别器还没有识别出它的手势(状态)(Possible)，但是可能计算触摸事件。这是默认状态 */
    CNCApplicationCellStatePossible,
    /** 识别器已经接收识别为此手势(状态)的触摸(Began)。在下一轮run循环中，响应方法将会被调用。 */
    CNCApplicationCellStateBegan,
    /** 识别器已经接收到触摸，并且识别为手势改变(Changed)。在下一轮run循环中，响应方法将会被调用。 */
    CNCApplicationCellStateChanged,
    /** 识别器已经接收到触摸，这种触摸导致手势取消(Cancelled)。在下一轮run循环中，响应方法将会被调用。识别器将会被重置到UIGestureRecognizerStatePossible状态。 */
    CNCApplicationCellStateCancelled,
    /** 识别器已经接收到触摸，并且识别为手势结束(Ended)。在下一轮run循环中，响应方法将会被调用并且识别器将会被重置到UIGestureRecognizerStatePossible状态 */
    CNCApplicationCellStateEnded,
    /** 识别器已经接收到一个触摸序列，不能识别为手势(Failed)。响应方法将不会被调用，并且识别器将会重置到UIGestureRecognizerStatePossible。 */
    CNCApplicationCellStateFailed,
    /** 离散手势 - 手势识别器识别一个离散事件，但是不会报告改变（例如，一个轻击）不会过度到Began和Changed状态，并且不会失败(fail)或者被取消(cancell)。 */
    CNCApplicationCellStateRecognized = CNCApplicationCellStatePossible,
};

@protocol CNCApplicationCellDelegate
@optional

/**
 滑动cell时执行

 @param cell 当前滑动的cell
 @param state 当前滑动状态
 @param point 偏移量
 */
- (void)cnc_applicationCell:(CNCApplicationCell *)cell state:(CNCApplicationCellState)state point:(CGPoint)point;
@end

@interface CNCApplicationCell : UICollectionViewCell

/** 应用logo */
@property(nonatomic, strong) UIImageView *appIcon;

/** 应用名称 */
@property(nonatomic, strong) QMUILabel *appName;

/** 最后操作时间 */
@property(nonatomic, strong) QMUILabel *lastTime;

/** 应用版本 */
@property(nonatomic, strong) QMUILabel *appVersion1;

/** 应用版本状态指示器 */
@property(nonatomic, strong) UIView *appVerison1Activity;

/** 应用版本 */
@property(nonatomic, strong) QMUILabel *appVersion2;

/** 应用版本状态指示器 */
@property(nonatomic, strong) UIView *appVerison2Activity;

@property(nonatomic, weak) id <CNCApplicationCellDelegate> delegate;

@end
