//
//  ClockViewController.m
//  Animations
//
//  Created by YouXianMing on 15/12/3.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "ClockViewController.h"
#import "GCD.h"
#import "UIView+SetRect.h"
#import "SystemTimeInfomation.h"
#import "RotateAnimationView.h"
#import "UIView+GlowView.h"
#import "EasingRotateAnimationType.h"
#import "POPSpringRotateAnimationType.h"

#define   ONE_SEC   (M_PI * 2 / 60.f)
#define   ONE_MIN   (M_PI * 2 / 3600.f)
#define   ONE_HOUR  (M_PI * 2 / 3600.f / 12.f)

@interface ClockViewController ()

@property (nonatomic, strong)  RotateAnimationView  *hourView;
@property (nonatomic, strong)  RotateAnimationView  *secondView;
@property (nonatomic, strong)  RotateAnimationView  *minuteView;

@property (nonatomic)          CGFloat               hourCount;
@property (nonatomic)          CGFloat               secondCount;
@property (nonatomic)          CGFloat               minuteCount;

@property (nonatomic, strong)  GCDTimer             *timer;

@end

@implementation ClockViewController

- (void)setup {

    [super setup];
    
    NSDictionary *currentTime = [[SystemTimeInfomation sharedInstance] currentTimeInfomation];
    
    CGFloat min  = [currentTime[@"mm"] floatValue];
    CGFloat sec  = [currentTime[@"ss"] floatValue];
    CGFloat hour = [currentTime[@"HH"] floatValue];
    
    {
        // 小时
        _hourCount                     = ONE_HOUR * (60 * 60 * hour + min * 60 + sec);
        self.hourView                  = [[RotateAnimationView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        self.hourView.center           = self.contentView.middlePoint;
        self.hourView.duration         = 0.75f;
        self.hourView.fromCircleRadian = 0.f;
        self.hourView.toCircleRadian   = self.hourView.fromCircleRadian + _hourCount;
        [self.contentView addSubview:self.hourView];
        [self.hourView startRotateAnimated:NO];
        
        // 小时图片
        UIImageView *hourView          = [[UIImageView alloc] initWithFrame:self.hourView.bounds];
        hourView.image                 = [UIImage imageNamed:@"hour"];
        [self.hourView addSubview:hourView];
        
        hourView.glowRadius            = @(2.f);
        hourView.glowOpacity           = @(0.75f);
        hourView.glowColor             = [[UIColor redColor] colorWithAlphaComponent:1.f];
        
        hourView.glowDuration          = @(1.f);
        hourView.hideDuration          = @(1.f);
        hourView.glowAnimationDuration = @(1.f);
        
        [hourView createGlowLayer];
        [hourView insertGlowLayer];
        [hourView startGlowLoop];
    }
    
    {
        // 分钟
        _minuteCount                     = ONE_MIN * (min * 60 + sec);
        self.minuteView                  = [[RotateAnimationView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        self.minuteView.center           = self.contentView.middlePoint;
        self.minuteView.duration         = 0.75f;
        self.minuteView.fromCircleRadian = 0.f;
        self.minuteView.toCircleRadian   = self.minuteView.fromCircleRadian + _minuteCount;
        [self.contentView addSubview:self.minuteView];
        [self.minuteView startRotateAnimated:NO];
        
        // 分钟图片
        UIImageView *minuteView          = [[UIImageView alloc] initWithFrame:self.minuteView.bounds];
        minuteView.image                 = [UIImage imageNamed:@"min"];
        [self.minuteView addSubview:minuteView];
    }
    
    {
        // 秒钟
        _secondCount                     = ONE_SEC * sec;
        self.secondView                  = [[RotateAnimationView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        self.secondView.center           = self.contentView.middlePoint;
        self.secondView.duration         = 0.75f;
        self.secondView.fromCircleRadian = 0.f;
        self.secondView.toCircleRadian   = self.secondView.fromCircleRadian + _secondCount;
        self.secondView.animationType    = [EasingRotateAnimationType new];
//        self.secondView.animationType    = [POPSpringRotateAnimationType new];
        [self.contentView addSubview:self.secondView];
        [self.secondView startRotateAnimated:NO];
        
        // 秒钟图片
        UIImageView *secondView          = [[UIImageView alloc] initWithFrame:self.secondView.bounds];
        secondView.image                 = [UIImage imageNamed:@"sec"];
        [self.secondView addSubview:secondView];
        
        secondView.glowRadius            = @(2.f);
        secondView.glowOpacity           = @(0.75f);
        secondView.glowColor             = [[UIColor cyanColor] colorWithAlphaComponent:1.f];
        
        secondView.glowDuration          = @(1.f);
        secondView.hideDuration          = @(1.f);
        secondView.glowAnimationDuration = @(1.f);
        
        [secondView createGlowLayer];
        [secondView insertGlowLayer];
        [secondView startGlowLoop];
    }

    {
        // 表盘
        UIView *circleRound            = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250.f, 250.f)];
        circleRound.layer.cornerRadius = 250 / 2.f;
        circleRound.layer.borderColor  = [UIColor blackColor].CGColor;
        circleRound.layer.borderWidth  = 2.f;
        circleRound.center             = self.contentView.middlePoint;
        [self.contentView addSubview:circleRound];
        
        // 中心红点
        UIView *circle            = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
        circle.layer.cornerRadius = 6 / 2.f;
        circle.backgroundColor    = [UIColor redColor];
        circle.center             = self.contentView.middlePoint;
        [self.contentView addSubview:circle];
    }
    
    _md_get_weakSelf();
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        [weakSelf timerEvent];
        
    } timeIntervalWithSecs:1.f];
    [self.timer start];
}

- (void)timerEvent {

    _secondCount                    += ONE_SEC;
    self.secondView.fromCircleRadian = self.secondView.toCircleRadian;
    self.secondView.toCircleRadian   = _secondCount;
    [self.secondView startRotateAnimated:YES];
    
    _minuteCount                    += ONE_MIN;
    self.minuteView.fromCircleRadian = self.minuteView.toCircleRadian;
    self.minuteView.toCircleRadian   = _minuteCount;
    [self.minuteView startRotateAnimated:YES];
    
    _hourCount                    += ONE_HOUR;
    self.hourView.fromCircleRadian = self.hourView.toCircleRadian;
    self.hourView.toCircleRadian   = _hourCount;
    [self.hourView startRotateAnimated:YES];
}

@end
