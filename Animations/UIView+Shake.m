//
//  UIView+Shake.m
//  Animations
//
//  Created by YouXianMing on 16/2/25.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIView+Shake.h"
#import <objc/runtime.h>

#define HAS_OPT(options, option) ((options & option) == option)

@interface SCShakeInfo : NSObject

@property (assign, nonatomic)   CGAffineTransform baseTransform;
@property (assign, nonatomic)   BOOL shaking;
@property (assign, nonatomic)   SCShakeOptions options;
@property (assign, nonatomic)   CGFloat force;
@property (assign, nonatomic)   CGFloat duration;
@property (assign, nonatomic)   CGFloat iterationDuration;
@property (assign, nonatomic)   CFTimeInterval startTime;
@property (strong, nonatomic)   ShakeCompletionHandler completionHandler;
@property (assign, nonatomic)   BOOL reversed;
@property (readonly, nonatomic) CGFloat completionRatio;

@end

@implementation SCShakeInfo

- (CGFloat)completionRatio {
    
    return (CACurrentMediaTime() - self.startTime) / self.duration;
}

@end

@implementation UIView (Shake)

static const char *ShakeInfoKey = "ShakeInfo";

- (void)shake {
    
    [self shakeWithOptions:kDefaultShakeOptions
                     force:kDefaultShakeForce
                  duration:kDefaultShakeDuration
         iterationDuration:kDefaultShakeIterationDuration
         completionHandler:nil];
}

- (void)shakeWithOptions:(SCShakeOptions)shakeOptions
                   force:(CGFloat)force
                duration:(CGFloat)duration
       iterationDuration:(CGFloat)iterationDuration
       completionHandler:(ShakeCompletionHandler)completionHandler {
    
    SCShakeInfo *shakeInfo = [self shakeInfo];
    
    shakeInfo.options           = shakeOptions;
    shakeInfo.force             = force;
    shakeInfo.startTime         = CACurrentMediaTime();
    shakeInfo.duration          = duration;
    shakeInfo.iterationDuration = iterationDuration;
    shakeInfo.completionHandler = completionHandler;
    
    if (!shakeInfo.shaking) {
        
        shakeInfo.baseTransform = self.transform;
        shakeInfo.shaking       = YES;
        
        [self _doAnimation:1];
    }
}

- (CGFloat)_getInterpolationRatio:(CGFloat)completionRatio options:(SCShakeOptions)options {
    
    CGFloat (*interpFunc)(CGFloat) = nil;
    
    if (HAS_OPT(options, SCShakeOptionsForceInterpolationRandom)) {
        
        interpFunc =& InterpolateRandom;
        
    } else if (HAS_OPT(options, SCShakeOptionsForceInterpolationExpDown)) {
        
        interpFunc =& InterpolateExpDown;
        
    } else if (HAS_OPT(options, SCShakeOptionsForceInterpolationExpUp)) {
        
        interpFunc =& InterpolateExpUp;
        
    } else if (HAS_OPT(options, SCShakeOptionsForceInterpolationLinearDown)) {
        
        interpFunc =& InterpolateLinearDown;
        
    } else if (HAS_OPT(options, SCShakeOptionsForceInterpolationLinearUp)) {
        
        interpFunc =& InterpolateLinearUp;
        
    } else {
        
        interpFunc =& InterpolateNone;
    }
    
    return interpFunc(completionRatio);
}

- (void)_animate:(CGFloat)force shakeInfo:(SCShakeInfo *)shakeInfo {
    
    CGAffineTransform baseTransform = shakeInfo.baseTransform;
    SCShakeOptions    options       = shakeInfo.options;
    
    if (HAS_OPT(options, SCShakeOptionsDirectionHorizontalAndVertical)) {
        
        if (arc4random_uniform(2) == 1) {
            
            self.transform = CGAffineTransformTranslate(baseTransform, 0, force * self.bounds.size.height);
            
        } else {
            
            self.transform = CGAffineTransformTranslate(baseTransform, force * self.bounds.size.width, 0);
        }
        
    } else if (HAS_OPT(options, SCShakeOptionsDirectionVertical)) {
        
        self.transform = CGAffineTransformTranslate(baseTransform, 0, force * self.bounds.size.height);
        
    } else if (HAS_OPT(options, SCShakeOptionsDirectionHorizontal)) {
        
        self.transform = CGAffineTransformTranslate(baseTransform, force * self.bounds.size.width, 0);
        
    } else {
        
        self.transform = CGAffineTransformRotate(baseTransform, force * M_PI_2);
    }
}

- (void)_doAnimation:(CGFloat)direction {
    
    SCShakeInfo *shakeInfo  = [self shakeInfo];
    SCShakeOptions options  = shakeInfo.options;
    CGFloat completionRatio = shakeInfo.completionRatio;
    
    if (completionRatio > 1) {
        
        completionRatio = 1;
    }
    
    if (shakeInfo.reversed) {
        
        completionRatio = 1 - completionRatio;
    }
    
    CGFloat interpolationRatio = [self _getInterpolationRatio:completionRatio options:options];
    CGFloat force              = shakeInfo.force * interpolationRatio * direction;
    CGFloat iterationDuration  = shakeInfo.iterationDuration;
    
    [UIView animateWithDuration:iterationDuration animations:^{
        
        [self _animate:force shakeInfo:shakeInfo];
        
    } completion:^(BOOL finished) {
        
        if (shakeInfo.shaking) {
            
            BOOL shouldRecurse = YES;
            if (shakeInfo.completionRatio > 1) {
                
                if (HAS_OPT(shakeInfo.options, SCShakeOptionsAutoreverse)) {
                    
                    shakeInfo.reversed = !shakeInfo.reversed;
                }
                
                if (shakeInfo.reversed || HAS_OPT(shakeInfo.options, SCShakeOptionsAtEndRestart)) {
                    
                    shakeInfo.startTime = CACurrentMediaTime();
                    
                } else if (!HAS_OPT(shakeInfo.options, SCShakeOptionsAtEndContinue)) {
                    
                    shouldRecurse = NO;
                    [self endShake];
                }
            }
            
            if (shouldRecurse) {
                
                [self _doAnimation:direction * -1];
            }
        }
    }];
}

- (void)endShake {
    
    SCShakeInfo *shakeInfo = [self shakeInfo];
    
    if (shakeInfo.shaking) {
        
        shakeInfo.shaking                        = NO;
        self.transform                           = shakeInfo.baseTransform;
        ShakeCompletionHandler completionHandler = shakeInfo.completionHandler;
        shakeInfo.completionHandler              = nil;
        
        if (completionHandler != nil) {
            
            completionHandler();
        }
    }
}

- (BOOL)isShaking {
    
    return [self shakeInfo].shaking;
}

- (SCShakeInfo *)shakeInfo {
    
    SCShakeInfo *shakeInfo = objc_getAssociatedObject(self, ShakeInfoKey);
    
    if (shakeInfo == nil) {
        
        shakeInfo = [SCShakeInfo new];
        objc_setAssociatedObject(self, ShakeInfoKey, shakeInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return shakeInfo;
}

#pragma Interpolations functions

static CGFloat InterpolateLinearUp(CGFloat input) {
    
    return input;
}

static CGFloat InterpolateLinearDown(CGFloat input) {
    
    return 1 - input;
}

static CGFloat Exp(CGFloat a, int power) {
    
    if (a < 0.5f) {
        
        return (float)pow(a * 2, power) / 2;
        
    } else {
    
        return (float)pow((a - 1) * 2, power) / (power % 2 == 0 ? -2 : 2) + 1;
    }
}

static CGFloat InterpolateExpUp(CGFloat input) {
    
    return Exp(input, 4);
}

static CGFloat InterpolateExpDown(CGFloat input) {
    
    return Exp(1 - input, 4);
}

static CGFloat InterpolateNone(CGFloat input) {
    
    return 1;
}

static CGFloat InterpolateRandom(CGFloat input) {
    
    CGFloat randNb = arc4random_uniform(10000);
    return randNb / 10000.0;
}

@end
