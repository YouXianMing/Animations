//
//  PopStrokeController.m
//  Animations
//
//  Created by YouXianMing on 15/11/17.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "PopStrokeController.h"
#import "GCD.h"
#import "POP.h"
#import "StrokeCircleLayerConfigure.h"
#import "UIView+SetRect.h"

@interface PopStrokeController ()

@property (nonatomic, strong) CAShapeLayer  *circleShape;
@property (nonatomic, strong) GCDTimer      *timer;

@end

@implementation PopStrokeController

- (void)setup {
    
    [super setup];
    
    self.circleShape           = [CAShapeLayer layer];
    self.circleShape.strokeEnd = 0.f;
    self.circleShape.lineCap   = kCALineCapRound;
    
    StrokeCircleLayerConfigure *config = [StrokeCircleLayerConfigure new];
    config.lineWidth                   = 4.f;
    config.startAngle                  = 0;
    config.endAngle                    = M_PI * 2;
    config.radius                      = 55.f;
    config.circleCenter                = self.contentView.middlePoint;
    config.strokeColor                 = [UIColor cyanColor];
    [config configCAShapeLayer:self.circleShape];
    [self.contentView.layer addSublayer:self.circleShape];
    
    _timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];

    _md_get_weakSelf();
    [_timer event:^{
        
        CGFloat value1 = arc4random() % 101 / 100.f;
        CGFloat value2 = arc4random() % 101 / 100.f;
        
        POPSpringAnimation *strokeAnimationEnd = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
        strokeAnimationEnd.toValue             = @(value1 > value2 ? value1 : value2);
        strokeAnimationEnd.springBounciness    = 12.f;
        
        POPSpringAnimation *strokeAnimationStart = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
        strokeAnimationStart.toValue             = @(value1 < value2 ? value1 : value2);
        strokeAnimationStart.springBounciness    = 12.f;
        
        POPBasicAnimation *strokeAnimationColor  = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeColor];
        strokeAnimationColor.toValue             = (__bridge id)([weakSelf randomColor].CGColor);
        
        [weakSelf.circleShape pop_addAnimation:strokeAnimationEnd forKey:@"layerStrokeAnimation"];
        [weakSelf.circleShape pop_addAnimation:strokeAnimationStart forKey:@"layerStrokeAnimation1"];
        [weakSelf.circleShape pop_addAnimation:strokeAnimationColor forKey:@"layerStrokeAnimation2"];
        
    } timeIntervalWithSecs:1];
    
    [_timer start];
}

- (UIColor *)randomColor {

    return [UIColor colorWithRed:arc4random() % 101 / 100.f green:arc4random() % 101 / 100.f blue:arc4random() % 101 / 100.f alpha:1];
}

@end
