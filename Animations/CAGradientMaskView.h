//
//  CAGradientMaskView.h
//  Animations
//
//  Created by YouXianMing on 16/2/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAGradientMaskView : UIView

/**
 *  Image显示方式
 */
@property (nonatomic) UIViewContentMode  contentMode;

/**
 *  渐变动画的时间
 */
@property (nonatomic) NSTimeInterval     fadeDuradtion;

/**
 *  要显示的相片
 */
@property (nonatomic, strong) UIImage   *image;

/**
 *  开始隐藏动画
 *
 *  @param animated 是否执行动画
 */
- (void)fadeAnimated:(BOOL)animated;

/**
 *  开始显示动画
 *
 *  @param animated 时候执行动画
 */
- (void)showAnimated:(BOOL)animated;

@end
