//
//  SpringEffectController.m
//  Animations
//
//  Created by YouXianMing on 16/1/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SpringEffectController.h"
#import "UIView+SetRect.h"

@interface SpringEffectController () {
    
    CGPoint  _centerPoint;
}

@property (nonatomic, strong) UIView         *pointView;
@property (nonatomic, strong) CAShapeLayer   *shapeLayer;
@property (nonatomic, strong) CADisplayLink  *displayLink;

@end

@implementation SpringEffectController

- (void)setup {
    
    [super setup];
    
    _centerPoint = self.contentView.center;
    
    self.shapeLayer           = [CAShapeLayer layer];
    self.shapeLayer.frame     = self.contentView.bounds;
    self.shapeLayer.fillColor = [UIColor redColor].CGColor;
    self.shapeLayer.path      = [self calculatePathWithPoint:CGPointMake(Width / 2.f, Height / 2.f)].CGPath;
    [self.contentView.layer addSublayer:self.shapeLayer];
    
    self.pointView        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
    self.pointView.center = self.contentView.center;
    [self.contentView addSubview:self.pointView];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkEvent)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureEvent:)];
    [self.contentView addGestureRecognizer:panGesture];
    
}

- (UIBezierPath *)calculatePathWithPoint:(CGPoint)point {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, Height / 2.f)];
    [path addLineToPoint:CGPointMake(0, Height)];
    [path addLineToPoint:CGPointMake(Width, Height)];
    [path addLineToPoint:CGPointMake(Width, Height / 2.f)];
    [path addQuadCurveToPoint:CGPointMake(0, Height / 2.f)
                 controlPoint:point];
    
    return path;
}

- (void)panGestureEvent:(UIPanGestureRecognizer *)panGesture {
    
    CGPoint point          = [panGesture locationInView:panGesture.view];
    CGPoint calculatePoint = CGPointMake((point.x + _centerPoint.x) / 2.f, (point.y + _centerPoint.y) / 2.f);
    
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        
        self.shapeLayer.path  = [self calculatePathWithPoint:calculatePoint].CGPath;
        self.pointView.center = calculatePoint;
        
    } else if (panGesture.state == UIGestureRecognizerStateCancelled ||
               panGesture.state == UIGestureRecognizerStateEnded ||
               panGesture.state == UIGestureRecognizerStateFailed) {
                
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.25f initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             self.pointView.center = self.contentView.center;
                             
                         } completion:nil];
    }
}

- (void)displayLinkEvent {
    
    CALayer *layer       = self.pointView.layer.presentationLayer;
    self.shapeLayer.path = [self calculatePathWithPoint:layer.position].CGPath;
}

- (void)viewDidDisappear:(BOOL)animated {

    [self.displayLink invalidate];
    [super viewDidDisappear:animated];
}

@end
