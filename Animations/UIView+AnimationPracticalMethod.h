//
//  UIView+AnimationPracticalMethod.h
//  ZiPeiYi
//
//  Created by YouXianMing on 16/2/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AnimationPracticalMethod)

/**
 *  Set the view's alpha.
 *
 *  @param alpha    Alpha.
 *  @param duration Animation's duration.
 *  @param animated Animated or not.
 */
- (void)alpha:(CGFloat)alpha duration:(NSTimeInterval)duration animated:(BOOL)animated;

@end
