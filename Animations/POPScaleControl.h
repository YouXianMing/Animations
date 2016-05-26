//
//  POPScaleControl.h
//  Animations
//
//  Created by YouXianMing on 16/5/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class POPScaleControl;

@protocol POPScaleControlDelegate <NSObject>

@optional

/**
 *  缩放百分比事件
 *
 *  @param controll POPControll对象
 *  @param percent  百分比
 */
- (void)POPControll:(POPScaleControl *)control currentScalePercent:(CGFloat)percent;

/**
 *  事件触发
 *
 *  @param controll POPControll对象
 */
- (void)POPControllEvent:(POPScaleControl *)control;

@end

@interface POPScaleControl : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id <POPScaleControlDelegate>  delegate;

/**
 *  缩放比例,默认值为0.95
 */
@property (nonatomic) CGFloat  scale;

/**
 *  动画时间,默认值为0.4
 */
@property (nonatomic) CFTimeInterval scaleDuration;

/**
 *  事件触发的敏感时间,默认值为0.4,敏感时间应该大于或者等于动画时间scaleDuration
 */
@property (nonatomic) CFTimeInterval sensitiveDuration;

/**
 *  目标对象
 */
@property (nonatomic, weak) id target;

/**
 *  事件
 */
@property (nonatomic) SEL      selector;

/**
 *  是否有效
 */
@property (nonatomic) BOOL     enabled;

/**
 *  是否选中
 */
@property (nonatomic) BOOL     selected;

#pragma mark - Read only properties.

/**
 *  按下按钮的百分比,初始未按下为0
 */
@property (nonatomic, assign, readonly) CGFloat percent;

#pragma mark - Properties used by SubClass & Methods Overwrite by subClass.

/**
 *  容器view,用于子类添加控件
 */
@property (nonatomic, strong, readonly) UIView  *contentView;

/**
 *  当前缩放比例(子类继承的时候重载)
 *
 *  @param percent 比例
 */
- (void)currentScalePercent:(CGFloat)percent;

/**
 *  事件激活了
 */
- (void)controllEventActived;

@end
