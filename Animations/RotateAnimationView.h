//
//  RotateAnimationView.h
//  Animations
//
//  Created by YouXianMing on 15/12/3.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RotateAnimationViewTypeProtocol.h"

@interface RotateAnimationView : UIView

/**
 *  Animation duration.
 */
@property (nonatomic) NSTimeInterval  duration;

/**
 *  Start angle's radian, default value is 0.
 */
@property (nonatomic) CGFloat         fromCircleRadian;

/**
 *  Animated to specified angle's radian, default value is M_PI (M_PI equal 360°).
 */
@property (nonatomic) CGFloat         toCircleRadian;

/**
 *  Animation type, default value is NormalRotateAnimationType.
 */
@property (nonatomic, strong)         id <RotateAnimationViewTypeProtocol> animationType;

/**
 *  Start rotate animation.
 *
 *  @param animated Animated or not.
 */
- (void)startRotateAnimated:(BOOL)animated;

@end
