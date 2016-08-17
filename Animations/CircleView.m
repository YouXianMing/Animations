//
//  CircleView.m
//  YXMWeather
//
//  Created by XianMingYou on 15/11/12.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "CircleView.h"

@interface CircleView ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createCircleLayer];
    }
    
    return self;
}

- (void)createCircleLayer {
    
    self.circleLayer       = [CAShapeLayer layer];
    self.circleLayer.frame = self.bounds;
    [self.layer addSublayer:self.circleLayer];
}

- (CGFloat)radianFromDegree:(CGFloat)degree {

    return ((M_PI * (degree))/ 180.f);
}

- (void)makeConfigEffective {
    
    CGFloat  lineWidth = (self.lineWidth <= 0 ? 1 : self.lineWidth);
    UIColor *lineColor = (self.lineColor == nil ? [UIColor blackColor] : self.lineColor);
    CGSize   size      = self.bounds.size;
    CGFloat  radius    = size.width / 2.f - lineWidth / 2.f;
    
    // Set clockWise or not.
    BOOL    clockWise  = self.clockWise;
    CGFloat startAngle = 0;
    CGFloat endAngle   = 0;
    
    if (clockWise == YES) {
        
        startAngle = -[self radianFromDegree:180 - self.startAngle];
        endAngle   = [self radianFromDegree:180 + self.startAngle];
        
    } else {
        
        startAngle = [self radianFromDegree:180 - self.startAngle];
        endAngle   = -[self radianFromDegree:180 + self.startAngle];
    }
    
    // Create path.
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.height / 2.f, size.width / 2.f)
                                                              radius:radius
                                                          startAngle:startAngle
                                                            endAngle:endAngle
                                                           clockwise:clockWise];
    self.circleLayer.path = circlePath.CGPath;
    
    // Set shapeLayer fill color & stroke color.
    self.circleLayer.strokeColor = lineColor.CGColor;
    self.circleLayer.fillColor   = [[UIColor clearColor] CGColor];
    self.circleLayer.lineWidth   = lineWidth;
    self.circleLayer.strokeEnd   = 0.f;
}

- (void)strokeEnd:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration {
    
    if (value <= 0) {
        
        value = 0;
        
    } else if (value >= 1) {
        
        value = 1.f;
    }
    
    if (animated) {
        
        // CAKeyframeAnimation
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath              = @"strokeEnd";
        keyAnimation.duration             = duration;
        keyAnimation.values               = [YXEasing calculateFrameFromValue:self.circleLayer.strokeEnd toValue:value
                                                                         func:func frameCount:duration * 60];
        
        // Start animation.
        self.circleLayer.strokeEnd = value;
        [self.circleLayer addAnimation:keyAnimation forKey:nil];
        
    } else {
        
        // DisableActions.
        [CATransaction setDisableActions:YES];
        self.circleLayer.strokeEnd = value;
        [CATransaction setDisableActions:NO];
    }
}

- (void)strokeStart:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration {
    
    if (value <= 0) {
        
        value = 0;
        
    } else if (value >= 1) {
        
        value = 1.f;
    }
    
    if (animated) {
        
        // CAKeyframeAnimation
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath              = @"strokeStart";
        keyAnimation.duration             = duration;
        keyAnimation.values               = [YXEasing calculateFrameFromValue:self.circleLayer.strokeStart toValue:value
                                                                         func:func frameCount:duration * 60];
        
        // Start animation.
        self.circleLayer.strokeStart = value;
        [self.circleLayer addAnimation:keyAnimation forKey:nil];
        
    } else {
        
        // DisableActions.
        [CATransaction setDisableActions:YES];
        self.circleLayer.strokeStart = value;
        [CATransaction setDisableActions:NO];
    }
}

+ (instancetype)circleViewWithFrame:(CGRect)frame lineWidth:(CGFloat)width lineColor:(UIColor *)color
                          clockWise:(BOOL)clockWise startAngle:(CGFloat)angle {
    
    CircleView *circleView = [[CircleView alloc] initWithFrame:frame];
    circleView.lineWidth   = width;
    circleView.lineColor   = color;
    circleView.clockWise   = clockWise;
    circleView.startAngle  = angle;
    [circleView makeConfigEffective];
    
    return circleView;
}

@end
