//
//  UIView+GlowView.m
//  GlowView
//
//  Created by YouXianMing on 15/7/4.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "UIView+GlowView.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) CALayer           *glowLayer;
@property (nonatomic, strong) dispatch_source_t  dispatchSource;

@end

@implementation UIView (GlowView)

- (void)createGlowLayer {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:self.bounds];
    [[self accessGlowColor] setFill];
    [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0];
    
    self.glowLayer               = [CALayer layer];
    self.glowLayer.frame         = self.bounds;
    self.glowLayer.contents      = (__bridge id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    self.glowLayer.opacity       = 0.f;
    self.glowLayer.shadowOffset  = CGSizeMake(0, 0);
    self.glowLayer.shadowOpacity = 1.f;
    
    UIGraphicsEndImageContext();
}

- (void)insertGlowLayer {
    
    if (self.glowLayer) {
        
        [self.layer addSublayer:self.glowLayer];
    }
}

- (void)removeGlowLayer {
    
    if (self.glowLayer) {
        
        [self.glowLayer removeFromSuperlayer];
    }
}

- (void)glowToshowAnimated:(BOOL)animated {
    
    self.glowLayer.shadowColor   = [self accessGlowColor].CGColor;
    self.glowLayer.shadowRadius  = [self accessGlowRadius].floatValue;
    
    if (animated) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue         = @(0.f);
        animation.toValue           = [self accessGlowOpacity];
        self.glowLayer.opacity      = [self accessGlowOpacity].floatValue;
        animation.duration          = [self accessAnimationDuration].floatValue;
        
        [self.glowLayer addAnimation:animation forKey:@"glowLayerOpacity"];
        
    } else {
    
        [self.glowLayer removeAnimationForKey:@"glowLayerOpacity"];
        self.glowLayer.opacity = [self accessGlowOpacity].floatValue;
    }
}

- (void)glowToHideAnimated:(BOOL)animated {
    
    self.glowLayer.shadowColor   = [self accessGlowColor].CGColor;
    self.glowLayer.shadowRadius  = [self accessGlowRadius].floatValue;
    
    if (animated) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue         = [self accessGlowOpacity];
        animation.toValue           = @(0.f);
        self.glowLayer.opacity      = 0.f;
        animation.duration          = [self accessAnimationDuration].floatValue;
        
        [self.glowLayer addAnimation:animation forKey:@"glowLayerOpacity"];
        
    } else {
    
        [self.glowLayer removeAnimationForKey:@"glowLayerOpacity"];
        self.glowLayer.opacity = 0.f;
    }
}

- (void)startGlowLoop {
    
    if (self.dispatchSource == nil) {
        
        CGFloat seconds      = [self accessAnimationDuration].floatValue * 2 + [self accessGlowDuration].floatValue + [self accessHideDuration].floatValue;
        CGFloat delaySeconds = [self accessAnimationDuration].floatValue + [self accessGlowDuration].floatValue;
        
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        
        __weak UIView *weakSelf = self;
        dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), NSEC_PER_SEC * seconds, 0);
        dispatch_source_set_event_handler(self.dispatchSource, ^{
            
            [weakSelf glowToshowAnimated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delaySeconds), dispatch_get_main_queue(), ^{
                
                [weakSelf glowToHideAnimated:YES];
            });
        });
        
        dispatch_resume(self.dispatchSource);
    }
}

#pragma mark - 处理数据越界问题

- (NSNumber *)accessGlowOpacity {
    
    if (self.glowOpacity) {
        
        if (self.glowOpacity.floatValue <= 0 || self.glowOpacity.floatValue > 1) {
            
            return @(0.8);
            
        } else {
            
            return self.glowOpacity;
        }
        
    } else {
        
        return @(0.8);
    }
}

- (NSNumber *)accessGlowDuration {
    
    if (self.glowDuration) {
        
        if (self.glowDuration.floatValue <= 0) {
            
            return @(0.5f);
            
        } else {
            
            return self.glowDuration;
        }
        
    } else {
        
        return @(0.5f);
    }
}

- (NSNumber *)accessHideDuration {
    
    if (self.hideDuration) {
        
        if (self.hideDuration.floatValue < 0) {
            
            return @(0.5);
            
        } else {
            
            return self.hideDuration;
        }
        
    } else {
        
        return @(0.5f);
    }
}

- (NSNumber *)accessAnimationDuration {
    
    if (self.glowAnimationDuration) {
        
        if (self.glowAnimationDuration.floatValue <= 0) {
            
            return @(1.f);
            
        } else {
            
            return self.glowAnimationDuration;
        }
        
    } else {
        
        return @(1.f);
    }
}

- (UIColor *)accessGlowColor {
    
    if (self.glowColor) {
        
        return self.glowColor;
        
    } else {
        
        return [UIColor redColor];
    }
}

- (NSNumber *)accessGlowRadius {
    
    if (self.glowRadius) {
        
        if (self.glowRadius.floatValue <= 0) {
            
            return @(2.f);
            
        } else {
            
            return self.glowRadius;
        }
        
    } else {
        
        return @(2.f);
    }
}

#pragma mark - runtime属性

- (void)setDispatchSource:(dispatch_source_t)dispatchSource {
    
    objc_setAssociatedObject(self, @selector(dispatchSource), dispatchSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)dispatchSource {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowColor:(UIColor *)glowColor {
    
    objc_setAssociatedObject(self, @selector(glowColor), glowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)glowColor {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowOpacity:(NSNumber *)glowOpacity {
    
    objc_setAssociatedObject(self, @selector(glowOpacity), glowOpacity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowOpacity {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowRadius:(NSNumber *)glowRadius {
    
    objc_setAssociatedObject(self, @selector(glowRadius), glowRadius, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowRadius {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowAnimationDuration:(NSNumber *)glowAnimationDuration {
    
    objc_setAssociatedObject(self, @selector(glowAnimationDuration), glowAnimationDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowAnimationDuration {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowDuration:(NSNumber *)glowDuration {
    
    objc_setAssociatedObject(self, @selector(glowDuration), glowDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowDuration {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHideDuration:(NSNumber *)hideDuration {
    
    objc_setAssociatedObject(self, @selector(hideDuration), hideDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)hideDuration {
    
    return objc_getAssociatedObject(self, _cmd);
}

NSString * const _recognizerGlowLayer = @"_recognizerGlowLayer";

- (void)setGlowLayer:(CALayer *)glowLayer {
    
    objc_setAssociatedObject(self, @selector(glowLayer), glowLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)glowLayer {
    
    return objc_getAssociatedObject(self, _cmd);
}

@end
