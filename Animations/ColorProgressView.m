//
//  ColorProgressView.m
//  Animations
//
//  Created by YouXianMing on 16/1/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ColorProgressView.h"

@interface ColorProgressView () {

    CGFloat  _width;
    CGFloat  _height;
}

@property (nonatomic, strong) UIView           *baseView;
@property (nonatomic, strong) CAGradientLayer  *gradientLayer;

@end

@implementation ColorProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _width  = self.frame.size.width;
        _height = self.frame.size.height;
        
        // BaseView
        self.baseView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, _height)];
        self.baseView.layer.masksToBounds = YES;
        [self addSubview:self.baseView];
        
        // CAGradientLayer
        self.gradientLayer       = [CAGradientLayer layer];
        self.gradientLayer.frame = self.bounds;
        [self.baseView.layer addSublayer:self.gradientLayer];
        
        // ProgressColor
        self.color = [ProgressColor new];
    }
    
    return self;
}

- (void)startAnimation {

    self.gradientLayer.colors     = _color.colors;
    self.gradientLayer.startPoint = _color.startPoint;
    self.gradientLayer.endPoint   = _color.endPoint;
    
    [self doAnimation];
}

- (void)doAnimation {
    
    NSArray *fromColors = _color.colors;
    NSArray *toColors   = [_color loopMove];
    _color.colors       = toColors;
    
    CABasicAnimation *animation   = [CABasicAnimation animationWithKeyPath:@"colors"];
    
    animation.fromValue           = fromColors;
    animation.toValue             = toColors;
    animation.duration            = _color.duration;
    
    animation.removedOnCompletion = YES;
    animation.fillMode            = kCAFillModeForwards;
    animation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.delegate            = self;
    
    self.gradientLayer.colors     = toColors;
    
    [self.gradientLayer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self doAnimation];
}

@synthesize progress = _progress;

- (void)setProgress:(CGFloat)progress {

    _progress = progress;
    
    if (progress <= 0) {
        
        _baseView.frame = CGRectMake(0, 0, 0, _height);
        
    } else if (progress <= 1) {
    
        _baseView.frame = CGRectMake(0, 0, _progress * _width, _height);
        
    } else {
    
        _baseView.frame = CGRectMake(0, 0, _width, _height);
    }
}

- (CGFloat)progress {

    return _progress;
}

@end
