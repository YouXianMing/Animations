//
//  WaterWaveViewController.m
//  Animations
//
//  Created by YouXianMing on 16/8/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "WaterWaveViewController.h"
#import "WaveView.h"
#import "UIView+SetRect.h"
#import "DefaultNotificationCenter.h"
#import "NSObject+WeakList.h"
#import "GCD.h"

typedef enum : NSUInteger {
    
    kWaveOne = 1000,
    kWaveTwo,
    kWaveThree,
    
} EWaterWaveViewControllerViewTag;

@interface WaterWaveViewController () <DefaultNotificationCenterDelegate>

@property (nonatomic, strong) DefaultNotificationCenter *notificationCenter;

@end

@implementation WaterWaveViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.contentView.layer.masksToBounds = YES;
    
    // Register notification.
    self.notificationCenter          = [DefaultNotificationCenter new];
    self.notificationCenter.delegate = self;
    [self.notificationCenter addNotificationName:UIApplicationDidBecomeActiveNotification];
    
    // WaveThree
    {
        WaveView *waveView = [[WaveView alloc] initWithFrame:CGRectMake(0, 0, Width * 2, self.contentView.height)];
        waveView.phase     = 7.5f;
        waveView.waveCrest = 10.f;
        waveView.waveCount = 2;
        waveView.type      = kStrokeWave | kFillWave;
        [self.contentView addSubview:waveView];
        [self setWeakObject:waveView idValue:kWaveThree];
        
        {
            DrawingStyle *fillStyle = [DrawingStyle new];
            fillStyle.fillColor     = [DrawingColor colorWithUIColor:[[UIColor redColor] colorWithAlphaComponent:0.25f]];
            waveView.fillStyle      = fillStyle;
            
            DrawingStyle *strokeStyle = [DrawingStyle new];
            strokeStyle.strokeColor   = [DrawingColor colorWithUIColor:[[UIColor redColor] colorWithAlphaComponent:0.15f]];
            strokeStyle.lineWidth     = 0.5f;
            waveView.strokeStyle      = strokeStyle;
        }
    }
    
    // WaveTwo
    {
        WaveView *waveView = [[WaveView alloc] initWithFrame:CGRectMake(0, 0, Width * 2, self.contentView.height)];
        waveView.phase     = 5.f;
        waveView.waveCrest = 15.f;
        waveView.waveCount = 2;
        waveView.type      = kStrokeWave | kFillWave;
        [self.contentView addSubview:waveView];
        [self setWeakObject:waveView idValue:kWaveTwo];
        
        {
            DrawingStyle *fillStyle = [DrawingStyle new];
            fillStyle.fillColor     = [DrawingColor colorWithUIColor:[[UIColor redColor] colorWithAlphaComponent:0.5f]];
            waveView.fillStyle      = fillStyle;
            
            DrawingStyle *strokeStyle = [DrawingStyle new];
            strokeStyle.strokeColor   = [DrawingColor colorWithUIColor:[[UIColor redColor] colorWithAlphaComponent:0.25f]];
            strokeStyle.lineWidth     = 0.5f;
            waveView.strokeStyle      = strokeStyle;
        }
    }
    
    // WaveOne
    {
        WaveView *waveView = [[WaveView alloc] initWithFrame:CGRectMake(0, 0, Width * 2, self.contentView.height)];
        waveView.phase     = 0.f;
        waveView.waveCrest = 20.f;
        waveView.waveCount = 2;
        waveView.type      = kStrokeWave | kFillWave;
        [self.contentView addSubview:waveView];
        [self setWeakObject:waveView idValue:kWaveOne];
        
        {
            DrawingStyle *fillStyle = [DrawingStyle new];
            fillStyle.fillColor     = [DrawingColor colorWithUIColor:[UIColor redColor]];
            waveView.fillStyle      = fillStyle;
            
            DrawingStyle *strokeStyle = [DrawingStyle new];
            strokeStyle.strokeColor   = [DrawingColor colorWithUIColor:[[UIColor redColor] colorWithAlphaComponent:0.5f]];
            strokeStyle.lineWidth     = 0.5f;
            waveView.strokeStyle      = strokeStyle;
        }
    }
    
    [self readyToBegin];
}

- (void)readyToBegin {
    
     UIView *waveOne   = [self weakObjectWithIdValue:kWaveOne];
     UIView *waveTwo   = [self weakObjectWithIdValue:kWaveTwo];
     UIView *waveThree = [self weakObjectWithIdValue:kWaveThree];
    
    [waveOne.layer   removeAllAnimations];
    [waveTwo.layer   removeAllAnimations];
    [waveThree.layer removeAllAnimations];
    
    waveOne.x   = 0.f;
    waveTwo.x   = 0.f;
    waveThree.x = 0.f;
    
    [self doAnimation];
}

- (void)doAnimation {
    
    {
        UIView *waveView = [self weakObjectWithIdValue:kWaveOne];
        [UIView animateWithDuration:2.f
                              delay:0
                            options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             waveView.x = -Width;
                             
                         } completion:nil];
    }
    
    {
        UIView *waveView = [self weakObjectWithIdValue:kWaveTwo];
        [UIView animateWithDuration:4.f
                              delay:0
                            options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             waveView.x = -Width;
                             
                         } completion:nil];
    }
    
    {
        UIView *waveView = [self weakObjectWithIdValue:kWaveThree];
        [UIView animateWithDuration:6.f
                              delay:0
                            options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             waveView.x = -Width;
                             
                         } completion:nil];
    }
}

#pragma mark - DefaultNotificationCenterDelegate

- (void)defaultNotificationCenter:(DefaultNotificationCenter *)notification name:(NSString *)name object:(id)object {
    
    if ([name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        
        [self readyToBegin];
    }
}

@end
