//
//  NSObject+RotateAnimationProtocol.m
//  RotateView
//
//  Created by YouXianMing on 15/7/31.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "UIView+RotateAnimationProtocol.h"
#import <objc/runtime.h>

@implementation UIView (RotateAnimationProtocol)

/**
 *  rotateDuration
 */
NSString * const _recognizerRotateDuration = @"_recognizerRotateDuration";

- (void)setRotateDuration:(CGFloat)rotateDuration {

    NSNumber *value = @(rotateDuration);
    objc_setAssociatedObject(self, (__bridge const void *)(_recognizerRotateDuration),
                             value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)rotateDuration {

    NSNumber *value = objc_getAssociatedObject(self, (__bridge const void *)(_recognizerRotateDuration));
    return [value floatValue];
}

/**
 *  defaultTransform
 */
NSString * const _recognizerDefaultTransform = @"_recognizerDefaultTransform";

- (void)setDefaultTransform:(CGAffineTransform)defaultTransform {

    NSValue *value = [NSValue valueWithCGAffineTransform:defaultTransform];
    objc_setAssociatedObject(self, (__bridge const void *)(_recognizerDefaultTransform),
                             value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGAffineTransform)defaultTransform {

    NSValue *value = objc_getAssociatedObject(self, (__bridge const void *)(_recognizerDefaultTransform));
    return [value CGAffineTransformValue];
}

@end
