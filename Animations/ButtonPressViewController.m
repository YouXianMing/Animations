//
//  ButtonPressViewController.m
//  Facebook-POP-Animation
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "ButtonPressViewController.h"
#import "POP.h"
#import "UIColor+CustomColors.h"
#import "StrokeCircleLayerConfigure.h"
#import "FillCircleLayerConfigure.h"

@interface ButtonPressViewController ()

@property (nonatomic, strong) UIButton          *button;
@property (nonatomic, strong) CAShapeLayer      *circleShape1;
@property (nonatomic, strong) CAShapeLayer      *circleShape2;

@property (nonatomic, strong) UILabel           *label;

@end

@implementation ButtonPressViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - setup
- (void)setup {
    
    [super setup];
    
    // 完整显示按住按钮后的动画效果
    _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _button.layer.cornerRadius = 50.f;
    _button.backgroundColor = [UIColor cyanColor];
    _button.center = self.view.center;
    [self.view addSubview:_button];
    
    self.label               = [[UILabel alloc] initWithFrame:_button.bounds];
    self.label.font          = Font_HYQiHei(30);
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text          = @"0%";
    [self.button addSubview:self.label];
    
    // 按住按钮后没有松手的动画
    [_button addTarget:self
                action:@selector(scaleToSmall)
      forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    
    // 按住按钮松手后的动画
    [_button addTarget:self
                action:@selector(scaleAnimations)
      forControlEvents:UIControlEventTouchUpInside];
    
    // 按住按钮后拖拽出去的动画
    [_button addTarget:self
                action:@selector(scaleToDefault)
      forControlEvents:UIControlEventTouchDragExit];
    
    // 圆环1
    {
        self.circleShape1 = [CAShapeLayer layer];
        self.circleShape1.strokeEnd = 0.f;
        StrokeCircleLayerConfigure *config = [StrokeCircleLayerConfigure new];
        config.lineWidth    = 0.5f;
        config.startAngle   = 0;
        config.endAngle     = M_PI * 2;
        config.radius       = 55.f;
        config.circleCenter = self.view.center;
        [config configCAShapeLayer:self.circleShape1];
        [self.view.layer addSublayer:self.circleShape1];
    }
    
    // 圆环2
    {
        self.circleShape2 = [CAShapeLayer layer];
        self.circleShape2.strokeEnd = 0.f;
        StrokeCircleLayerConfigure *config = [StrokeCircleLayerConfigure new];
        config.lineWidth    = 0.5f;
        config.startAngle   = 0;
        config.endAngle     = M_PI * 2;
        config.radius       = 60.f;
        config.clockWise    = YES;
        config.circleCenter = self.view.center;
        [config configCAShapeLayer:self.circleShape2];
        [self.view.layer addSublayer:self.circleShape2];
    }
}

#pragma mark - Button events
- (void)scaleToSmall {
    
    [_button.layer pop_removeAllAnimations];
    
    // 变小尺寸
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue            = [NSValue valueWithCGSize:CGSizeMake(0.7f, 0.7f)];
    scaleAnimation.delegate           = self;
    [_button.layer pop_addAnimation:scaleAnimation forKey:nil];
    
    // 颜色
    POPSpringAnimation *backgroundColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    backgroundColor.toValue             = (id)[UIColor magentaColor].CGColor;
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
    backgroundColor.toValue             = (id)[UIColor cyanColor].CGColor;
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
    backgroundColor.toValue             = (id)[UIColor cyanColor].CGColor;
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
    CGFloat percent         = (size.height - calculateConstant(0, 1, 1, 0.7))/calculateSlope(0, 1, 1, 0.7);
    _circleShape1.strokeEnd = percent;
    _circleShape2.strokeEnd = percent;
    [CATransaction setDisableActions:NO];

    double showValue = fabs(percent * 100);
    self.label.text  = [NSString stringWithFormat:@"%.f%%", showValue];
}

#pragma mark - Y = kX + b
CGFloat calculateSlope(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2) {
    
    return (y2 - y1) / (x2 - x1);
}

CGFloat calculateConstant(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2) {
    
    return (y1*(x2 - x1) - x1*(y2 - y1)) / (x2 - x1);
}

@end
