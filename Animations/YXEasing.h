//
//  YXEasing.h
//  Prize
//
//  Copyright (c) 2015年 Y.X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "easing.h"

// +--------------------+
//   Easing动画简单的解析
// +--------------------+
//
// http://easings.net/zh-cn
// http://gizma.com/easing/
// 
// BackEase        ：在某一动画开始沿指示的路径进行动画处理前稍稍收回该动画的移动。
// BounceEase      ：创建弹跳效果。
// CircleEase      ：创建使用循环函数加速和/或减速的动画。
// CubicEase       ：创建使用公式 f(t) = t^3 加速和/或减速的动画。
// ElasticEase     ：创建类似于弹簧在停止前来回振荡的动画。
// ExponentialEase ：创建使用指数公式加速和/或减速的动画。
// PowerEase       ：创建使用公式 f(t) = t^p（其中，p 等于 Power 属性）加速和/或减速的动画。
// QuadraticEase   ：创建使用公式 f(t) = t^2 加速和/或减速的动画。
// QuarticEase     ：创建使用公式 f(t) = t^4 加速和/或减速的动画。
// QuinticEase     ：创建使用公式 f(t) = t^5 加速和/或减速的动画。
// SineEase        ：创建使用正弦公式加速和/或减速的动画。
// 
// LinearInterpolation
// 
// QuadraticEaseIn
// QuadraticEaseOut
// QuadraticEaseInOut
// 
// CubicEaseIn
// CubicEaseOut
// CubicEaseInOut
// 
// QuarticEaseIn
// QuarticEaseOut
// QuarticEaseInOut
// 
// QuinticEaseIn
// QuinticEaseOut
// QuinticEaseInOut
// 
// SineEaseIn
// SineEaseOut
// SineEaseInOut
// 
// CircularEaseIn
// CircularEaseOut
// CircularEaseInOut
// 
// ExponentialEaseIn
// ExponentialEaseOut
// ExponentialEaseInOut
// 
// ElasticEaseIn
// ElasticEaseOut
// ElasticEaseInOut
// 
// BackEaseIn
// BackEaseOut
// BackEaseInOut
// 
// BounceEaseIn
// BounceEaseOut
// BounceEaseInOut

@interface YXEasing : NSObject

/**
 *  Calculate frames by value.
 *
 *  @param fromValue  Start value.
 *  @param toValue    End value.
 *  @param func       Easing function method.
 *  @param frameCount Frame count one second.
 *
 *  @return Values Calculated.
 */
+ (NSArray *)calculateFrameFromValue:(CGFloat)fromValue
                             toValue:(CGFloat)toValue
                                func:(AHEasingFunction)func
                          frameCount:(size_t)frameCount;

/**
 *  Calculate frames by point.
 *
 *  @param fromPoint  Start point.
 *  @param toPoint    End point.
 *  @param func       Easing function method.
 *  @param frameCount Frame count one second.
 *
 *  @return Values Calculated.
 */
+ (NSArray *)calculateFrameFromPoint:(CGPoint)fromPoint
                             toPoint:(CGPoint)toPoint
                                func:(AHEasingFunction)func
                          frameCount:(size_t)frameCount;

/**
 *  Calculate frames by size.
 *
 *  @param fromSize   Start size.
 *  @param toSize     End size.
 *  @param func       Easing function method.
 *  @param frameCount Frame count one second.
 *
 *  @return Values Calculated.
 */
+ (NSArray *)calculateFrameFromSize:(CGSize)fromSize
                             toSize:(CGSize)toSize
                               func:(AHEasingFunction)func
                         frameCount:(size_t)frameCount;

@end
