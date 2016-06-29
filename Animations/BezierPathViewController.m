//
//  BezierPathViewController.m
//  Animations
//
//  Created by YouXianMing on 16/1/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BezierPathViewController.h"
#import "UIView+SetRect.h"
#import "CALayer+SetRect.h"
#import "UIFont+Fonts.h"
#import "UIView+AnimationProperty.h"
#import "GCD.h"

@interface BezierPathViewController ()

@end

@implementation BezierPathViewController

- (void)setup {
    
    [super setup];
    
    // Scale value.
    CGFloat scale = 1;
    
    if (iPhone4_4s || iPhone5_5s) {

        scale = 0.65f;
        
    } else if (iPhone6_6s) {
    
        scale = 0.75f;
        
    } else if (iPhone6_6sPlus) {
        
        scale = 0.8f;
    }
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    // Used as background.
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame         = CGRectMake(0, 0, 600, 300);
        shapeLayer.path          = [self path].CGPath;
        
        shapeLayer.fillColor   = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.lineWidth   = 0.5f;
        shapeLayer.opacity     = 0.5f;
        shapeLayer.position    = self.contentView.middlePoint;
        [shapeLayer setTransform:CATransform3DMakeScale(scale, scale, 1.f)];
        
        [self.contentView.layer addSublayer:shapeLayer];
    }
    
    // Red line animation.
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame         = CGRectMake(0, 0, 600, 300);
        shapeLayer.path          = [self path].CGPath;
        shapeLayer.strokeEnd     = 0.f;
        
        shapeLayer.fillColor     = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor   = [UIColor redColor].CGColor;
        shapeLayer.lineWidth     = 2.f;
        shapeLayer.position      = self.contentView.middlePoint;
        shapeLayer.shadowColor   = [UIColor redColor].CGColor;
        shapeLayer.shadowOpacity = 1.f;
        shapeLayer.shadowRadius  = 4.f;
        shapeLayer.lineCap       = kCALineCapRound;
        [shapeLayer setTransform:CATransform3DMakeScale(scale, scale, 1.f)];
        [self.contentView.layer addSublayer:shapeLayer];
        
        CGFloat MAX = 0.98f;
        CGFloat GAP = 0.02;
        
        CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        aniStart.fromValue         = [NSNumber numberWithFloat:0.f];
        aniStart.toValue           = [NSNumber numberWithFloat:MAX];
        
        CABasicAnimation *aniEnd   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        aniEnd.fromValue           = [NSNumber numberWithFloat:0.f + GAP];
        aniEnd.toValue             = [NSNumber numberWithFloat:MAX + GAP];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration          = 4.f;
        group.repeatCount       = CGFLOAT_MAX;
        group.autoreverses      = YES;
        group.animations        = @[aniEnd, aniStart];
        
        [shapeLayer addAnimation:group forKey:nil];
    }
    
    // Green line animation.
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame         = CGRectMake(0, 0, 600, 300);
        shapeLayer.path          = [self path].CGPath;
        shapeLayer.strokeEnd     = 0.f;
        
        shapeLayer.fillColor     = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor   = [UIColor greenColor].CGColor;
        shapeLayer.lineWidth     = 2.f;
        shapeLayer.position      = self.contentView.middlePoint;
        shapeLayer.shadowColor   = [UIColor greenColor].CGColor;
        shapeLayer.shadowOpacity = 1.f;
        shapeLayer.shadowRadius  = 4.f;
        shapeLayer.lineCap       = kCALineCapRound;
        [shapeLayer setTransform:CATransform3DMakeScale(scale, scale, 1.f)];
        [self.contentView.layer addSublayer:shapeLayer];
        
        CGFloat MAX = 0.98f;
        CGFloat GAP = 0.02;
        
        CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        aniStart.fromValue         = [NSNumber numberWithFloat:0.f];
        aniStart.toValue           = [NSNumber numberWithFloat:MAX];
        
        CABasicAnimation *aniEnd   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        aniEnd.fromValue           = [NSNumber numberWithFloat:0.f + GAP];
        aniEnd.toValue             = [NSNumber numberWithFloat:MAX + GAP];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration          = 8.f;
        group.repeatCount       = CGFLOAT_MAX;
        group.autoreverses      = YES;
        group.animations        = @[aniEnd, aniStart];
        
        [shapeLayer addAnimation:group forKey:nil];
    }
    
    // Cyan line animation.
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame         = CGRectMake(0, 0, 600, 300);
        shapeLayer.path          = [self path].CGPath;
        shapeLayer.strokeEnd     = 0.f;
        
        shapeLayer.fillColor     = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor   = [UIColor cyanColor].CGColor;
        shapeLayer.lineWidth     = 2.f;
        shapeLayer.position      = self.contentView.middlePoint;
        shapeLayer.shadowColor   = [UIColor cyanColor].CGColor;
        shapeLayer.shadowOpacity = 1.f;
        shapeLayer.shadowRadius  = 4.f;
        shapeLayer.lineCap       = kCALineCapRound;
        [shapeLayer setTransform:CATransform3DMakeScale(scale, scale, 1.f)];
        [self.contentView.layer addSublayer:shapeLayer];
        
        CGFloat MAX = 0.98f;
        CGFloat GAP = 0.02;
        
        CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        aniStart.fromValue         = [NSNumber numberWithFloat:MAX];
        aniStart.toValue           = [NSNumber numberWithFloat:0];
        
        CABasicAnimation *aniEnd   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        aniEnd.fromValue           = [NSNumber numberWithFloat:1.f];
        aniEnd.toValue             = [NSNumber numberWithFloat:GAP];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration          = 4.f;
        group.repeatCount       = CGFLOAT_MAX;
        group.autoreverses      = YES;
        group.animations        = @[aniEnd, aniStart];
        
        [shapeLayer addAnimation:group forKey:nil];
    }
    
    // Yellow line animation.
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame         = CGRectMake(0, 0, 600, 300);
        shapeLayer.path          = [self path].CGPath;
        shapeLayer.strokeEnd     = 0.f;
        
        shapeLayer.fillColor     = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor   = [UIColor yellowColor].CGColor;
        shapeLayer.lineWidth     = 2.f;
        shapeLayer.position      = self.contentView.middlePoint;
        shapeLayer.shadowColor   = [UIColor yellowColor].CGColor;
        shapeLayer.shadowOpacity = 1.f;
        shapeLayer.shadowRadius  = 4.f;
        shapeLayer.lineCap       = kCALineCapRound;
        [shapeLayer setTransform:CATransform3DMakeScale(scale, scale, 1.f)];
        [self.contentView.layer addSublayer:shapeLayer];
        
        CGFloat MAX = 0.98f;
        CGFloat GAP = 0.02;
        
        CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        aniStart.fromValue         = [NSNumber numberWithFloat:MAX];
        aniStart.toValue           = [NSNumber numberWithFloat:0];
        
        CABasicAnimation *aniEnd   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        aniEnd.fromValue           = [NSNumber numberWithFloat:1.f];
        aniEnd.toValue             = [NSNumber numberWithFloat:GAP];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration          = 8.f;
        group.repeatCount       = CGFLOAT_MAX;
        group.autoreverses      = YES;
        group.animations        = @[aniEnd, aniStart];
        
        [shapeLayer addAnimation:group forKey:nil];
    }
}

- (UIBezierPath *)path {
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint   : CGPointMake(0, 150)];
    [bezierPath addLineToPoint: CGPointMake(68, 150)];
    [bezierPath addLineToPoint: CGPointMake(83, 107)];
    [bezierPath addLineToPoint: CGPointMake(96, 206)];
    [bezierPath addLineToPoint: CGPointMake(102, 150)];
    [bezierPath addLineToPoint: CGPointMake(116, 150)];
    [bezierPath addLineToPoint: CGPointMake(127, 82)];
    [bezierPath addLineToPoint: CGPointMake(143, 213)];
    [bezierPath addLineToPoint: CGPointMake(160, 150)];
    [bezierPath addLineToPoint: CGPointMake(179, 150)];
    [bezierPath addLineToPoint: CGPointMake(183, 135)];
    [bezierPath addLineToPoint: CGPointMake(192, 169)];
    [bezierPath addLineToPoint: CGPointMake(199, 150)];
    [bezierPath addLineToPoint: CGPointMake(210, 177)];
    [bezierPath addLineToPoint: CGPointMake(227, 70)];
    [bezierPath addLineToPoint: CGPointMake(230, 210)];
    [bezierPath addLineToPoint: CGPointMake(249, 135)];
    [bezierPath addLineToPoint: CGPointMake(257, 150)];
    [bezierPath addLineToPoint: CGPointMake(360, 150)];
    [bezierPath addLineToPoint: CGPointMake(372, 124)];
    [bezierPath addLineToPoint: CGPointMake(395, 197)];
    [bezierPath addLineToPoint: CGPointMake(408, 82)];
    [bezierPath addLineToPoint: CGPointMake(416, 150)];
    [bezierPath addLineToPoint: CGPointMake(424, 135)];
    [bezierPath addLineToPoint: CGPointMake(448, 224)];
    [bezierPath addLineToPoint: CGPointMake(456, 107)];
    [bezierPath addLineToPoint: CGPointMake(463, 150)];
    [bezierPath addLineToPoint: CGPointMake(600, 150)];
    
    return bezierPath;
}

- (void)buildTitleView {
    
    [super buildTitleView];
    
    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = [UIFont AvenirWithFontSize:20.f];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.75f];
    headlinelabel.text          = self.title;
    [headlinelabel sizeToFit];
    
    headlinelabel.center = self.titleView.middlePoint;
    
    // Line.
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, self.view.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.titleView addSubview:line];
    [self.titleView addSubview:headlinelabel];
    
    // Back button.
    UIImage  *image      = [UIImage imageNamed:@"backIconVer2"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center    = CGPointMake(20, self.titleView.middleY);
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

@end
