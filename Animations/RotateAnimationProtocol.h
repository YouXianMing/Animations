//
//  RotateAnimationProtocol.h
//  RotateView
//
//  Created by YouXianMing on 15/7/31.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+RotateAnimationProtocol.h"

@protocol RotateAnimationProtocol <NSObject>

/**
 *  Rotate to up (default).
 *
 *  @param animated Animated or not.
 */
- (void)changeToUpAnimated:(BOOL)animated;

/**
 *  Rotate to left.
 *
 *  @param animated Animated or not.
 */
- (void)changeToLeftAnimated:(BOOL)animated;

/**
 *  Rotate to right.
 *
 *  @param animated Animated or not.
 */
- (void)changeToRightAnimated:(BOOL)animated;

/**
 *  Rotate to down.
 *
 *  @param animated Animated or not.
 */
- (void)changeToDownAnimated:(BOOL)animated;


@end
