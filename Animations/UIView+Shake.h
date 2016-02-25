//
//  UIView+Shake.h
//  Animations
//
//  Created by YouXianMing on 16/2/25.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

// https://github.com/rFlex/SCViewShaker

#define kDefaultShakeOptions  (SCShakeOptionsDirectionHorizontal | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndComplete)
#define kDefaultShakeForce    (0.075)
#define kDefaultShakeDuration (0.5)
#define kDefaultShakeIterationDuration (0.03)

typedef enum : NSUInteger {
    
    SCShakeOptionsDirectionRotate                = 0,
    SCShakeOptionsDirectionHorizontal            = 1,
    SCShakeOptionsDirectionVertical              = 2,
    SCShakeOptionsDirectionHorizontalAndVertical = 3,
    SCShakeOptionsForceInterpolationNone         = 4,
    SCShakeOptionsForceInterpolationLinearUp     = 8,
    SCShakeOptionsForceInterpolationLinearDown   = 16,
    SCShakeOptionsForceInterpolationExpUp        = 32,
    SCShakeOptionsForceInterpolationExpDown      = 64,
    SCShakeOptionsForceInterpolationRandom       = 128,
    SCShakeOptionsAtEndRestart                   = 256,
    SCShakeOptionsAtEndComplete                  = 512,
    SCShakeOptionsAtEndContinue                  = 1024,
    SCShakeOptionsAutoreverse                    = 2048
    
} SCShakeOptions;

typedef void(^ShakeCompletionHandler)();

@interface UIView (Shake)

/**
 *  Returns whether the view is currently shaking or not.
 */
@property (readonly, nonatomic) BOOL isShaking;

/**
 *  Shake the view using the default options. The view will be shaken for a short amount of time.
 */
- (void)shake;

/*
 Shake the view using the specified options.
 |shakeOptions| is an enum of options that can be activated by using the OR operator (like SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationNone).
 
 |force| is the coefficient of force to apply on each shake iteration (typically between 0 and 1 even though nothing prevents you for setting a higher value if you want).
 
 |duration| is the total duration of the shaking motion. This may be ignored depending of the options you set.
 iterationDuration is how long each shake iteration will last. You may want to set a very low value (like 0.02) if you want a proper shake effect.
 
 |completionHandler|, if not null, is the block that will be invoked when the shake finishes.
 */
- (void)shakeWithOptions:(SCShakeOptions)shakeOptions
                   force:(CGFloat)force duration:(CGFloat)duration
       iterationDuration:(CGFloat)iterationDuration
       completionHandler:(ShakeCompletionHandler)completionHandler;

/**
 *  End the current shaking action, if any
 */
- (void)endShake;

@end
