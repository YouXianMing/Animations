//
//  ButtonPressViewController.m
//  Facebook-POP-Animation
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "ButtonPressViewController.h"
#import "POP.h"
#import "StrokeCircleLayerConfigure.h"
#import "FillCircleLayerConfigure.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "UIImage+ImageEffects.h"
#import "Math.h"
#import "GCD.h"
#import "UIFont+Fonts.h"

@interface ButtonPressViewController ()

@property (nonatomic, strong) Math              *math;
@property (nonatomic, strong) UIButton          *button;
@property (nonatomic, strong) UILabel           *label;
@property (nonatomic, strong) CAShapeLayer      *circleShape1;
@property (nonatomic, strong) CAShapeLayer      *circleShape2;
@property (nonatomic, strong) UIImageView       *normalImageView;
@property (nonatomic, strong) UIImageView       *blurImageView;

@end

@implementation ButtonPressViewController

- (void)setup {
    
    [super setup];
    
    // Y = kX + b
    self.math = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0, 1) PointB:MATHPointMake(1, 0.9)];
    
    // 加载图片
    self.normalImageView             = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    self.blurImageView               = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    self.normalImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blurImageView.contentMode   = UIViewContentModeScaleAspectFill;
    UIImage *normalImage             = [UIImage imageNamed:@"1"];
    self.normalImageView.image       = normalImage;
    self.blurImageView.image         = [normalImage blurImage];
    [self.contentView addSubview:self.normalImageView];
    [self.contentView addSubview:self.blurImageView];
    
    // 完整显示按住按钮后的动画效果
    _button                    = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _button.layer.cornerRadius = 50.f;
    _button.backgroundColor    = [UIColor whiteColor];
    _button.center             = self.contentView.middlePoint;
    [self.contentView addSubview:_button];
    
    self.label               = [[UILabel alloc] initWithFrame:_button.bounds];
    self.label.font          = [UIFont HYQiHeiWithFontSize:30.f];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text          = @"0%";
    [self.button addSubview:self.label];
    
    // 按住按钮后没有松手的动画
    [_button addTarget:self action:@selector(scaleToSmall) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    
    // 按住按钮松手后的动画
    [_button addTarget:self action:@selector(scaleAnimations) forControlEvents:UIControlEventTouchUpInside];
    
    // 按住按钮后拖拽出去的动画
    [_button addTarget:self action:@selector(scaleToDefault) forControlEvents:UIControlEventTouchDragExit];
    
    // 圆环1
    {
        self.circleShape1                  = [CAShapeLayer layer];
        self.circleShape1.strokeEnd        = 0.f;
        StrokeCircleLayerConfigure *config = [StrokeCircleLayerConfigure new];
        config.lineWidth    = 0.5f;
        config.startAngle   = 0;
        config.endAngle     = M_PI * 2;
        config.radius       = 50.f;
        config.circleCenter = self.contentView.middlePoint;
        [config configCAShapeLayer:self.circleShape1];
        [self.contentView.layer addSublayer:self.circleShape1];
    }
    
    // 圆环2
    {
        self.circleShape2                  = [CAShapeLayer layer];
        self.circleShape2.strokeEnd        = 0.f;
        StrokeCircleLayerConfigure *config = [StrokeCircleLayerConfigure new];
        config.lineWidth    = 0.5f;
        config.startAngle   = 0;
        config.endAngle     = M_PI * 2;
        config.radius       = 52.f;
        config.clockWise    = YES;
        config.circleCenter = self.contentView.middlePoint;
        [config configCAShapeLayer:self.circleShape2];
        [self.contentView.layer addSublayer:self.circleShape2];
    }
}

#pragma mark - Button events
- (void)scaleToSmall {
    
    [_button.layer pop_removeAllAnimations];
    
    // 变小尺寸
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue            = [NSValue valueWithCGSize:CGSizeMake(0.9, 0.9)];
    scaleAnimation.delegate           = self;
    scaleAnimation.duration           = 0.8f;
    [_button.layer pop_addAnimation:scaleAnimation forKey:nil];
    
    // 颜色
    POPSpringAnimation *backgroundColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    backgroundColor.toValue             = (id)[UIColor blackColor].CGColor;
    [_button.layer pop_addAnimation:backgroundColor forKey:@"magentaColor"];
}

- (void)scaleAnimations {
    
    [_button.layer pop_removeAllAnimations];
    
    // 恢复尺寸
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue            = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.delegate           = self;
    [_button.layer pop_addAnimation:scaleAnimation forKey:nil];
    
    // 颜色
    POPSpringAnimation *backgroundColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    backgroundColor.toValue             = (id)[UIColor whiteColor].CGColor;
    [_button.layer pop_addAnimation:backgroundColor forKey:nil];
}

- (void)scaleToDefault{
    
    [_button.layer pop_removeAllAnimations];
    
    // 恢复尺寸
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue            = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.delegate           = self;
    [_button.layer pop_addAnimation:scaleAnimation forKey:nil];
    
    // 颜色
    POPSpringAnimation *backgroundColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    backgroundColor.toValue             = (id)[UIColor whiteColor].CGColor;
    [_button.layer pop_addAnimation:backgroundColor forKey:nil];
}

#pragma mark - POP delegate
- (void)pop_animationDidStart:(POPAnimation *)anim {

    NSLog(@"pop_animationDidStart %@", anim);
}

- (void)pop_animationDidReachToValue:(POPAnimation *)anim {

    NSLog(@"pop_animationDidReachToValue %@", anim);
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {

    NSLog(@"pop_animationDidStop %@", anim);
}

- (void)pop_animationDidApply:(POPAnimation *)anim {

    NSLog(@"pop_animationDidApply %@", anim);
    
    NSValue *toValue = (NSValue *)[anim valueForKeyPath:@"currentValue"];
    CGSize size      = [toValue CGSizeValue];
    
    [CATransaction setDisableActions:YES];
    CGFloat percent         = (size.height - _math.b) / _math.k;
    _circleShape1.strokeEnd = percent;
    _circleShape2.strokeEnd = percent;
    [CATransaction setDisableActions:NO];
    
    UIColor *color       = [UIColor colorWithRed:percent green:percent blue:percent alpha:1.f];
    double showValue     = fabs(percent * 100);
    self.label.text      = [NSString stringWithFormat:@"%.f%%", showValue];
    self.label.textColor = color;
    
    _blurImageView.alpha = 1 - percent;
}

@end
