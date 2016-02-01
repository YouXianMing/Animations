//
//  CASpringAnimationController.m
//  Animations
//
//  Created by YouXianMing on 16/1/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CASpringAnimationController.h"
#import "RangeValueView.h"
#import "UIView+SetRect.h"

@interface CASpringAnimationController ()

@property (nonatomic, strong) UIButton       *showView;

@property (nonatomic, strong) RangeValueView *stiffnessView;
@property (nonatomic, strong) RangeValueView *dampingView;
@property (nonatomic, strong) RangeValueView *massView;
@property (nonatomic, strong) RangeValueView *initialVelocityView;

@end

@implementation CASpringAnimationController

- (void)setup {
    
    [super setup];
    
    [self initRangeViews];
    
    [self initButton];
}

- (void)initButton {
    
    CGFloat gap = Height - 60 - 40*4 - 64;
    
    CGFloat width                    = 50.f;
    self.showView                    = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    self.showView.center             = CGPointMake(self.contentView.middleX, 64 + gap / 2.f);
    self.showView.backgroundColor    = [UIColor cyanColor];
    self.showView.layer.cornerRadius = width / 2.f;
    self.showView.x                  = Width / 2.f - 50;
    [self.showView addTarget:self action:@selector(doAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.showView];
}

- (void)doAnimation {
    
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"position.x"];
    springAnimation.stiffness          = self.stiffnessView.currentValue;
    springAnimation.mass               = self.massView.currentValue;
    springAnimation.damping            = self.dampingView.currentValue;
    springAnimation.initialVelocity    = self.initialVelocityView.currentValue;
    springAnimation.duration           = springAnimation.settlingDuration;
    
    springAnimation.fromValue    = @(Width / 2.f - 50);
    springAnimation.toValue      = @(Width / 2.f + 50);
    self.showView.layer.position = CGPointMake(Width / 2.f + 50, self.showView.layer.position.y);
    
    [self.showView.layer addAnimation:springAnimation forKey:nil];
}

- (void)initRangeViews {
    
    self.stiffnessView = [RangeValueView rangeValueViewWithFrame:CGRectMake(10, Height - 60, Width - 20, 0)
                                                            name:@"硬度  Stiffness"
                                                        minValue:10.f
                                                        maxValue:200.f
                                                    defaultValue:100.f];
    [self.contentView addSubview:self.stiffnessView];
    
    
    self.dampingView = [RangeValueView rangeValueViewWithFrame:CGRectMake(10, Height - 60 - 40, Width - 20, 0)
                                                          name:@"阻尼  Damping"
                                                      minValue:0.1f
                                                      maxValue:10.f
                                                  defaultValue:5.f];
    [self.contentView addSubview:self.dampingView];
    
    
    self.massView = [RangeValueView rangeValueViewWithFrame:CGRectMake(10, Height - 60 - 40*2, Width - 20, 0)
                                                       name:@"质量  Mass"
                                                   minValue:0.1
                                                   maxValue:20.f
                                               defaultValue:1.f];
    [self.contentView addSubview:self.massView];
    
    
    self.initialVelocityView = [RangeValueView rangeValueViewWithFrame:CGRectMake(10, Height - 60 - 40*3, Width - 20, 0)
                                                                  name:@"速度  Velocity"
                                                              minValue:-20.f
                                                              maxValue:20.f
                                                          defaultValue:0.f];
    [self.contentView addSubview:self.initialVelocityView];
}

@end
