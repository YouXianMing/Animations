//
//  SpringScaleViewController.m
//  Animations
//
//  Created by YouXianMing on 16/6/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SpringScaleViewController.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "GCD.h"
#import "POP.h"

@interface SpringScaleViewController ()

@property (nonatomic, strong) UIView *scaleView;

@end

@implementation SpringScaleViewController

- (void)setup {

    [super setup];
    
    // Label
    UILabel *label = [[UILabel alloc] init];
    label.text     = @"P   P";
    label.font     = [UIFont HYQiHeiWithFontSize:140];
    [label sizeToFit];
    label.center   = self.contentView.middlePoint;
    [self.contentView addSubview:label];
    
    // Circle
    self.scaleView                    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.scaleView.backgroundColor    = [[UIColor colorWithRed:0.203  green:0.598  blue:0.859 alpha:1] colorWithAlphaComponent:0.95f];
    self.scaleView.layer.cornerRadius = self.scaleView.width / 2.f;
    self.scaleView.center             = self.contentView.middlePoint;
    [self.contentView addSubview:self.scaleView];
    
    // Start animation after 1 second.
    [GCDQueue executeInMainQueue:^{
        
        [self scaleAnimation];
        
    } afterDelaySecs:1.f];
}

- (void)scaleAnimation {

    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    
    scaleAnimation.name               = @"scaleSmallAnimation";
    scaleAnimation.delegate           = self;
    
    scaleAnimation.duration           = 0.15f;
    scaleAnimation.toValue            = [NSValue valueWithCGPoint:CGPointMake(1.25, 1.25)];\
    
    [self.scaleView pop_addAnimation:scaleAnimation forKey:nil];
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {

    if ([anim.name isEqualToString:@"scaleSmallAnimation"]) {
        
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        
        scaleAnimation.name                = @"SpringAnimation";
        scaleAnimation.delegate            = self;
        
        scaleAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity            = [NSValue valueWithCGPoint:CGPointMake(-2, -2)];
        scaleAnimation.springBounciness    = 20.f;
        scaleAnimation.springSpeed         = 10.f;
        scaleAnimation.dynamicsTension     = 700.f;
        scaleAnimation.dynamicsFriction    = 7.f;
        scaleAnimation.dynamicsMass        = 3.f;
        
        [self.scaleView pop_addAnimation:scaleAnimation forKey:nil];
        
    } else if ([anim.name isEqualToString:@"SpringAnimation"]) {
    
        [self performSelector:@selector(scaleAnimation) withObject:nil afterDelay:1];
    }
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}

@end
