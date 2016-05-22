//
//  CustomButton.h
//  CustomButton
//
//  Created by YouXianMing on 16/5/21.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BaseControl.h"

typedef NS_OPTIONS(NSUInteger, BaseControlState) {
    
    BaseControlStateNormal = 1000,
    BaseControlStateHighlighted,
    BaseControlStateDisabled,
};

@interface CustomButton : BaseControl

/**
 *  目标
 */
@property (nonatomic, weak) id target;

/**
 *  按钮事件
 */
@property (nonatomic) SEL      buttonEvent;

/**
 *  普通背景色
 */
@property (nonatomic, strong) UIColor  *normalBackgroundColor;

/**
 *  高亮状态背景色
 */
@property (nonatomic, strong) UIColor  *highlightBackgroundColor;

/**
 *  禁用状态背景色
 */
@property (nonatomic, strong) UIColor  *disabledBackgroundColor;

/**
 *  状态值
 */
@property (nonatomic, readonly) BaseControlState  state;

/**
 *  按钮标题
 */
@property (nonatomic, strong) NSString *title;

/**
 *  字体
 */
@property (nonatomic, strong) UIFont   *font;

/**
 *  水平位移
 */
@property (nonatomic) CGFloat  horizontalOffset;

/**
 *  垂直位移
 */
@property (nonatomic) CGFloat  verticalOffset;

/**
 *  对其方式
 */
@property (nonatomic) NSTextAlignment   textAlignment;

/**
 *  给标题设置颜色
 *
 *  @param color 颜色
 *  @param state 状态
 */
- (void)setTitleColor:(UIColor *)color state:(BaseControlState)state;

/**
 *  切换到不同的状态
 *
 *  @param state    状态
 *  @param animated 是否执行动画
 */
- (void)changeToState:(BaseControlState)state animated:(BOOL)animated;

@end
