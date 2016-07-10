//
//  ButtonPressViewController.m
//  Facebook-POP-Animation
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "ButtonPressViewController.h"
#import "StrokeCircleLayerConfigure.h"
#import "FillCircleLayerConfigure.h"
#import "UIView+SetRect.h"
#import "UIImage+ImageEffects.h"
#import "PressScaleButton.h"

@interface ButtonPressViewController () <POPScaleControlDelegate>

@property (nonatomic, strong) CAShapeLayer       *circleShape1;
@property (nonatomic, strong) CAShapeLayer       *circleShape2;
@property (nonatomic, strong) UIImageView        *normalImageView;
@property (nonatomic, strong) UIImageView        *blurImageView;

@end

@implementation ButtonPressViewController

- (void)setup {
    
    [super setup];
    
    // Blur ImageView.
    self.normalImageView             = [[UIImageView alloc] initWithFrame:self.backgroundView.bounds];
    self.blurImageView               = [[UIImageView alloc] initWithFrame:self.backgroundView.bounds];
    self.normalImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blurImageView.contentMode   = UIViewContentModeScaleAspectFill;
    UIImage *normalImage             = [UIImage imageNamed:@"1"];
    self.normalImageView.image       = normalImage;
    self.blurImageView.image         = [normalImage blurImage];
    [self.backgroundView addSubview:self.normalImageView];
    [self.backgroundView addSubview:self.blurImageView];
    
    // PressScaleButton.
    PressScaleButton *button = [[PressScaleButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.center            = self.contentView.middlePoint;
    button.delegate          = self;
    button.target            = self;
    button.scaleDuration     = 0.6f;
    button.sensitiveDuration = 0.6f;
    button.selector          = @selector(componentEvent:);
    [self.contentView addSubview:button];

    // Circle One.
    {
        self.circleShape1                  = [CAShapeLayer layer];
        self.circleShape1.strokeEnd        = 0.f;
        StrokeCircleLayerConfigure *config = [StrokeCircleLayerConfigure new];
        config.lineWidth                   = 0.5f;
        config.startAngle                  = 0;
        config.endAngle                    = M_PI * 2;
        config.radius                      = 50.f;
        config.circleCenter                = self.contentView.middlePoint;
        [config configCAShapeLayer:self.circleShape1];
        [self.contentView.layer addSublayer:self.circleShape1];
    }
    
    // Circle Two.
    {
        self.circleShape2                  = [CAShapeLayer layer];
        self.circleShape2.strokeEnd        = 0.f;
        StrokeCircleLayerConfigure *config = [StrokeCircleLayerConfigure new];
        config.lineWidth                   = 0.5f;
        config.startAngle                  = 0;
        config.endAngle                    = M_PI * 2;
        config.radius                      = 52.f;
        config.clockWise                   = YES;
        config.circleCenter                = self.contentView.middlePoint;
        [config configCAShapeLayer:self.circleShape2];
        [self.contentView.layer addSublayer:self.circleShape2];
    }
}

#pragma mark - Component event.

- (void)componentEvent:(id)sender {

    NSLog(@"%@", sender);
}

#pragma mark - POPScaleControl's delegate.

- (void)POPControll:(POPScaleControl *)control currentScalePercent:(CGFloat)percent {

    _blurImageView.alpha = 1 - percent;
    
    [CATransaction setDisableActions:YES];
    _circleShape1.strokeEnd = percent;
    _circleShape2.strokeEnd = percent;
    [CATransaction setDisableActions:NO];
}

@end
