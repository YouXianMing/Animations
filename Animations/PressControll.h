//
//  PressControll.h
//  POPButtonVer2
//
//  Created by YouXianMing on 16/5/25.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PressControll;

@protocol PressControllDelegate <NSObject>

@optional

/**
 *  缩放百分比事件
 *
 *  @param controll PressControll对象
 *  @param percent  百分比
 */
- (void)pressControll:(PressControll *)controll currentPercent:(CGFloat)percent;

/**
 *  事件触发
 *
 *  @param controll PressControll对象
 */
- (void)pressControllEvent:(PressControll *)controll;

@end

@interface PressControll : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id <PressControllDelegate>  delegate;

/**
 *  动画时间,默认值为0.4
 */
@property (nonatomic) CFTimeInterval animationDuration;

/**
 *  事件触发的敏感时间,默认值为0.4,敏感时间应该大于或者等于动画时间animationDuration
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

#pragma mark - Properties used by SubClass & Methods Overwrite by subClass.

/**
 *  容器view,用于子类添加控件
 */
@property (nonatomic, strong, readonly) UIView  *contentView;

/**
 *  当前动画比例(子类继承的时候重载)
 *
 *  @param percent 比例
 */
- (void)currentPercent:(CGFloat)percent;

/**
 *  事件激活了
 */
- (void)controllEventActived;

@end
