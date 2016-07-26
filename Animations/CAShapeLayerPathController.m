//
//  CAShapeLayerPathController.m
//  Animations
//
//  Created by YouXianMing on 15/11/17.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CAShapeLayerPathController.h"
#import "PathView.h"
#import "UIView+SetRect.h"
#import "GCD.h"

@interface CAShapeLayerPathController ()

@property (nonatomic, strong) PathView *pathView;
@property (nonatomic, strong) GCDTimer *timer;

@property (nonatomic, strong) CAShapeLayer *lineShapeLayer;
@property (nonatomic, strong) CAShapeLayer *fillShapeLayer;

@property (nonatomic) CGPoint A;

@property (nonatomic, strong) CALayer *pointA;

@end

@implementation CAShapeLayerPathController

- (void)setup {
    
    [super setup];
    
    // background view
    self.pathView        = [[PathView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.pathView.center = self.contentView.middlePoint;
    self.pathView.gap    = 10.f;
    [self.pathView setNeedsDisplay];
    [self.contentView addSubview:self.pathView];
    UIBezierPath *path = [self randomPath];
    
    // point A
    self.pointA                 = [CALayer layer];
    self.pointA.frame           = CGRectMake(0, 0, 4, 4);
    self.pointA.cornerRadius    = 2.f;
    self.pointA.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f].CGColor;
    self.pointA.position        = CGPointMake(self.A.x + 10, self.A.y + 10);
    [self.pathView.layer addSublayer:self.pointA];
    
    // shape
    self.fillShapeLayer             = [CAShapeLayer layer];
    self.fillShapeLayer.path        = path.CGPath;
    self.fillShapeLayer.strokeColor = [UIColor clearColor].CGColor;
    self.fillShapeLayer.fillColor   = [UIColor cyanColor].CGColor;
    self.fillShapeLayer.lineWidth   = 0.f;
    self.fillShapeLayer.frame       = CGRectMake(self.pathView.gap, self.pathView.gap,
                                                 self.pathView.width - 2 * self.pathView.gap,
                                                 self.pathView.width - 2 * self.pathView.gap);
    [self.pathView.layer addSublayer:self.fillShapeLayer];
    
    // line
    self.lineShapeLayer                 = [CAShapeLayer layer];
    self.lineShapeLayer.path            = path.CGPath;
    self.lineShapeLayer.strokeColor     = [UIColor redColor].CGColor;
    self.lineShapeLayer.fillColor       = [UIColor clearColor].CGColor;
    self.lineShapeLayer.lineWidth       = 0.5f;
    self.lineShapeLayer.lineDashPattern = @[@(3), @(3)];
    self.lineShapeLayer.frame           = CGRectMake(self.pathView.gap, self.pathView.gap,
                                                     self.pathView.width - 2 * self.pathView.gap,
                                                     self.pathView.width - 2 * self.pathView.gap);
    [self.pathView.layer addSublayer:self.lineShapeLayer];
    
    // timer
    _md_get_weakSelf();
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        [weakSelf timerEvent];
        
    } timeIntervalWithSecs:1.f];
    [self.timer start];
}

- (void)timerEvent {

    // path animation.
    UIBezierPath *newPath            = [self randomPath];
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration          = 0.5;
    basicAnimation.fromValue         = (__bridge id)(self.lineShapeLayer.path);
    basicAnimation.toValue           = (__bridge id)newPath.CGPath;
    self.lineShapeLayer.path         = newPath.CGPath;
    self.fillShapeLayer.path         = newPath.CGPath;
    [self.lineShapeLayer addAnimation:basicAnimation forKey:@"lineShapeLayerPath"];
    [self.fillShapeLayer addAnimation:basicAnimation forKey:@"fillShapeLayerPath"];
    
    // fillColor animation.
    UIColor *newColor                = [self randomColor];
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    colorAnimation.duration          = 0.5;
    colorAnimation.fromValue         = (__bridge id)(self.fillShapeLayer.fillColor);
    colorAnimation.toValue           = (__bridge id)newColor.CGColor;
    self.fillShapeLayer.fillColor    = newColor.CGColor;
    [self.fillShapeLayer addAnimation:colorAnimation forKey:@"fillShapeLayerColor"];
    
    // path animation.
    CGPoint newPoint                    = CGPointMake(self.A.x + 10, self.A.y + 10);
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration          = 0.5f;
    positionAnimation.fromValue         = [NSValue valueWithCGPoint:self.pointA.position];
    positionAnimation.toValue           = [NSValue valueWithCGPoint:newPoint];
    self.pointA.position                = newPoint;
    [self.pointA addAnimation:positionAnimation forKey:@"positionAnimation"];
}

- (UIBezierPath *)randomPath {
    
    CGPoint pointA = [self randomPointA];
    CGPoint pointB = [self randomPointB];
    CGPoint pointC = [self randomPointC];
    CGPoint pointD = [self randomPointD];
    
    self.A = pointA;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:pointA];
    [bezierPath addLineToPoint:pointB];
    [bezierPath addLineToPoint:pointC];
    [bezierPath addLineToPoint:pointD];
    [bezierPath closePath];
    
    return bezierPath;
}

- (CGPoint)randomPointA {
    
    return CGPointMake(arc4random() % (int)(self.pathView.width - 2 * self.pathView.gap), 0);
}

- (CGPoint)randomPointB {
    
    return CGPointMake(self.pathView.width - 2 * self.pathView.gap, arc4random() % (int)(self.pathView.width - 2 * self.pathView.gap));
}

- (CGPoint)randomPointC {
    
    return CGPointMake(arc4random() % (int)(self.pathView.width - 2 * self.pathView.gap), self.pathView.width - 2 * self.pathView.gap);
}

- (CGPoint)randomPointD {
    
    return CGPointMake(0, arc4random() % (int)(self.pathView.width - 2 * self.pathView.gap));
}

- (UIColor *)randomColor {
    
    return [UIColor colorWithRed:arc4random() % 101 / 100.f green:arc4random() % 101 / 100.f blue:arc4random() % 101 / 100.f alpha:0.5f];
}

@end
