//
//  UIView+GlowView.h
//  GlowView
//
//  Created by YouXianMing on 15/7/4.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GlowView)

//
//                                     == 动画时间解析 ==
//
//  0.0 ------------- 0.0 ------------> glowOpacity [-------------] glowOpacity ------------> 0.0
//           T                 T                           T                          T
//           |                 |                           |                          |
//           |                 |                           |                          |
//           .                 .                           .                          .
//     hideDuration  glowAnimationDuration           glowDuration            glowAnimationDuration
//

#pragma mark - 设置辉光效果

/**
 *  辉光的颜色
 */
@property (nonatomic, strong) UIColor  *glowColor;

/**
 *  辉光的透明度
 */
@property (nonatomic, strong) NSNumber *glowOpacity;

/**
 *  辉光的阴影半径
 */
@property (nonatomic, strong) NSNumber *glowRadius;

#pragma mark - 设置辉光时间间隔

/**
 *  一次完整的辉光周期（从显示到透明或者从透明到显示），默认1s
 */
@property (nonatomic, strong) NSNumber *glowAnimationDuration;

/**
 *  保持辉光时间（不设置，默认为0.5s）
 */
@property (nonatomic, strong) NSNumber *glowDuration;

/**
 *  不显示辉光的周期（不设置默认为0.5s）
 */
@property (nonatomic, strong) NSNumber *hideDuration;

#pragma mark - 辉光相关操作

/**
 *  创建出辉光layer
 */
- (void)createGlowLayer;

/**
 *  插入辉光的layer
 */
- (void)insertGlowLayer;

/**
 *  移除辉光的layer
 */
- (void)removeGlowLayer;

/**
 *  显示辉光
 */
- (void)glowToshowAnimated:(BOOL)animated;

/**
 *  隐藏辉光
 */
- (void)glowToHideAnimated:(BOOL)animated;

/**
 *  开始循环辉光
 */
- (void)startGlowLoop;

@end
