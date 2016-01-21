//
//  AdditiveAnimationController.m
//  Animations
//
//  Created by YouXianMing on 16/1/21.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AdditiveAnimationController.h"
#import "UIView+SetRect.h"

@interface AdditiveAnimationController ()

@property (nonatomic, strong) CALayer  *layer;

@end

@implementation AdditiveAnimationController

- (void)setup {
    
    [super setup];
    
    // http://ronnqvi.st/multiple-animations/
    
    self.layer                 = [CALayer layer];
    self.layer.frame           = CGRectMake(0, 0, 30, 30);
    self.layer.backgroundColor = [UIColor redColor].CGColor;
    self.layer.cornerRadius    = 15.f;
    self.layer.position        = self.contentView.middlePoint;
    [self.contentView.layer addSublayer:self.layer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    [self.contentView addGestureRecognizer:tap];
}

- (void)tapEvent:(UITapGestureRecognizer *)tapGesture {
    
    CGPoint touchPoint      = [tapGesture locationInView:tapGesture.view];
    CGPoint differencePoint = CGPointMake(self.layer.position.x - touchPoint.x,
                                          self.layer.position.y - touchPoint.y);
    
    CALayer *presentationLayer = self.layer.presentationLayer;
    NSLog(@"%@", presentationLayer);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration          = 1.f;
    animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.additive          = true;
    animation.fromValue         = [NSValue valueWithCGPoint:differencePoint];
    animation.toValue           = [NSValue valueWithCGPoint:CGPointZero];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.layer.position = touchPoint;
    [CATransaction commit];
    
    [self.layer addAnimation:animation forKey:nil];
}

@end
