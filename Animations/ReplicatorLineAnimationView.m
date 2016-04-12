//
//  ReplicatorLineAnimationView.m
//  Animations
//
//  Created by YouXianMing on 16/4/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ReplicatorLineAnimationView.h"

@interface ReplicatorLineAnimationView () {
    
    CAReplicatorLayer *_replicatorLayer;
    CALayer           *_animationLayer;
    NSString          *_animationKeyPath;
    CGFloat            _animationToValue;
    CGFloat            _offsetX;
    CGFloat            _offsetY;
    CATransform3D      _instanceTransform;
    BOOL               _startAnimation;
}

@end

@implementation ReplicatorLineAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.speed             = 2.f;
        _replicatorLayer       = [CAReplicatorLayer layer];
        _replicatorLayer.frame = self.bounds;
        [self.layer addSublayer:_replicatorLayer];
        
        _animationLayer       = [CALayer layer];
        _animationLayer.frame = self.bounds;
        [_replicatorLayer addSublayer:_animationLayer];
        
        self.layer.masksToBounds = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventDidBecomeActive:)
                                                     name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    
    return self;
}

- (void)startAnimation {
    
    _startAnimation = YES;
    
    if (_animationKeyPath.length) {
        
        [_animationLayer removeAnimationForKey:_animationKeyPath];
    }
    
    [self dealWithTheEReplicatorLineDirection];
    
    _replicatorLayer.instanceCount      = 2;
    _replicatorLayer.instanceTransform  = _instanceTransform;
    _animationLayer.contents            = (__bridge id _Nullable)(self.image.CGImage);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:_animationKeyPath];
    animation.toValue           = @(_animationToValue);
    animation.duration          = 1.f / self.speed;
    animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount       = HUGE_VALF;
    [_animationLayer addAnimation:animation forKey:_animationKeyPath];
}

- (void)dealWithTheEReplicatorLineDirection {
    
    if (_direction == kReplicatorLeft || _direction == kReplicatorRight) {
        
        _animationKeyPath  = @"position.x";
        _offsetX           = _direction == kReplicatorLeft ? self.frame.size.width : -self.frame.size.width;
        _offsetY           = 0;
        _animationToValue  = _animationLayer.position.x - _offsetX;
        _instanceTransform = CATransform3DMakeTranslation(_offsetX, 0.0, 0.0);
        
    } else if (_direction == kReplicatorUp || _direction == kReplicatorDown) {
        
        _animationKeyPath  = @"position.y";
        _offsetX           = 0;
        _offsetY           = _direction == kReplicatorUp ? self.frame.size.height : -self.frame.size.height;
        _animationToValue  = _animationLayer.position.y - _offsetY;
        _instanceTransform = CATransform3DMakeTranslation(0.0, _offsetY, 0.0);
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)eventDidBecomeActive:(id)obj {
    
    NSNotification *fication = obj;
    
    if ([fication.name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        
        if (_startAnimation == YES) {
            
            [self startAnimation];
        }
    }
}

@end
