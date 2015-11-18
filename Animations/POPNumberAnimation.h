//
//  POPNumberAnimation.h
//  Animations
//
//  Created by YouXianMing on 15/11/18.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class POPNumberAnimation;

@protocol POPNumberAnimationDelegate <NSObject>

@required

/**
 *  When you run 'startAnimation' method, this delegate method will get current value for you in real time.
 *
 *  @param numberAnimation POPNumberAnimation object.
 *  @param currentValue    Current value in real time.
 */
- (void)POPNumberAnimation:(POPNumberAnimation *)numberAnimation currentValue:(CGFloat)currentValue;

@end

@interface POPNumberAnimation : NSObject

@property (nonatomic, weak) id <POPNumberAnimationDelegate>  delegate;

/**
 *  Animation's start value.
 */
@property (nonatomic)       CGFloat                          fromValue;

/**
 *  Animation's destination value.
 */
@property (nonatomic)       CGFloat                          toValue;

/**
 *  Current value.
 */
@property (nonatomic)       CGFloat                          currentValue;

/**
 *  Animation's duration, default value is 0.4s.
 */
@property (nonatomic)       NSTimeInterval                   duration;

/**
 *  Animation's timingFunction.
 */
@property (nonatomic, strong) CAMediaTimingFunction         *timingFunction;

/**
 *  When you have set all propeties, you must save values to make the config effect.
 */
- (void)saveValues;

/*
 *  Before you run this method, you should make sure save values to make the config effect.
 */
- (void)startAnimation;

/*
 *  Stop animation.
 */
- (void)stopAnimation;

@end
