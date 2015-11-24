//
//  CircleView.h
//  YXMWeather
//
//  Created by XianMingYou on 15/11/12.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXEasing.h"

@interface CircleView : UIView

/**
 *  线条宽度
 */
@property (nonatomic)         CGFloat   lineWidth;

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor  *lineColor;

/**
 *  旋转方向
 */
@property (nonatomic)         BOOL      clockWise;

/**
 *  开始角度
 */
@property (nonatomic)         CGFloat   startAngle;

/**
 *  初始化view
 */
- (void)buildView;

/**
 *  做strokeEnd动画
 *
 *  @param value    取值 [0, 1]
 *  @param func     函数指针
 *  @param animated 是否执行动画
 *  @param duration 动画持续的时间
 */
- (void)strokeEnd:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration;

/**
 *  做strokeStart动画
 *
 *  @param value    取值 [0, 1]
 *  @param func     函数指针
 *  @param animated 是否执行动画
 *  @param duration 动画持续的时间
 */
- (void)strokeStart:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration;

/**
 *  便利构造器创建出实例对象
 *
 *  @param frame     frame值
 *  @param width     线条宽度
 *  @param color     线条颜色
 *  @param clockWise 是否是顺时钟
 *  @param angle     开始是否的角度(取值范围 0° ~ 360°)
 *
 *  @return 实例对象
 */
+ (instancetype)circleViewWithFrame:(CGRect)frame
                          lineWidth:(CGFloat)width
                          lineColor:(UIColor *)color
                          clockWise:(BOOL)clockWise
                         startAngle:(CGFloat)angle;

@end
