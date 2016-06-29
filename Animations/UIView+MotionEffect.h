//
//  UIView+MotionEffect.h
//  MotionEffect
//
//  Created by YouXianMing on 16/2/18.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MotionEffect)

/**
 *  Add center motion effect.
 *
 *  https://github.com/jvenegas/TLMotionEffect
 *
 *  @param offset Offset.
 */
- (void)addCenterMotionEffectsWithOffset:(CGFloat)offset;

@end
