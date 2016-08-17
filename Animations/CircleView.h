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
 *  Line width.
 */
@property (nonatomic)         CGFloat   lineWidth;

/**
 *  Line color.
 */
@property (nonatomic, strong) UIColor  *lineColor;

/**
 *  Clockwise or not.
 */
@property (nonatomic)         BOOL      clockWise;

/**
 *  Start angle, range is 0°~360°
 */
@property (nonatomic)         CGFloat   startAngle;

/**
 *  Start strokeEnd animation.
 *
 *  @param value    StrokeEnd value, range is [0, 1].
 *  @param func     Easing function point.
 *  @param animated Animated or not.
 *  @param duration The animation's duration.
 */
- (void)strokeEnd:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration;

/**
 *  Start strokeStart animation.
 *
 *  @param value    StrokeEnd value, range is [0, 1].
 *  @param func     Easing function point.
 *  @param animated Animated or not.
 *  @param duration The animation's duration.
 */
- (void)strokeStart:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration;

/**
 *  Convenient constructor.
 *
 *  @param frame     View frame.
 *  @param width     Line width.
 *  @param color     Line color.
 *  @param clockWise Clockwise or not.
 *  @param angle     Start angle, range is 0°~360°.
 *
 *  @return CircleView instance.
 */
+ (instancetype)circleViewWithFrame:(CGRect)frame lineWidth:(CGFloat)width lineColor:(UIColor *)color
                          clockWise:(BOOL)clockWise startAngle:(CGFloat)angle;

@end
