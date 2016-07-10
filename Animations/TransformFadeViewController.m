//
//  TransformFadeViewController.m
//  Animations
//
//  Created by YouXianMing on 15/11/17.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "TransformFadeViewController.h"
#import "TranformFadeView.h"
#import "GCD.h"

typedef enum : NSUInteger {
    
    kTypeOne,
    kTypeTwo,
    
} EType;

@interface TransformFadeViewController ()

@property (nonatomic, strong) TranformFadeView *tranformFadeViewOne;
@property (nonatomic, strong) TranformFadeView *tranformFadeViewTwo;

@property (nonatomic, strong) GCDTimer *timer;
@property (nonatomic)         EType     type;

@property (nonatomic, strong) NSArray   *images;
@property (nonatomic)         NSInteger  count;

@end

@implementation TransformFadeViewController

- (void)setup {

    [super setup];
    
    self.images = @[[UIImage imageNamed:@"5"],
                    [UIImage imageNamed:@"1"],
                    [UIImage imageNamed:@"2"],
                    [UIImage imageNamed:@"3"],
                    [UIImage imageNamed:@"4"]];
    
    // 图片1
    self.tranformFadeViewOne                      = [[TranformFadeView alloc] initWithFrame:self.contentView.bounds];
    self.tranformFadeViewOne.contentMode          = UIViewContentModeScaleAspectFill;
    self.tranformFadeViewOne.image                = [self currentImage];
    self.tranformFadeViewOne.verticalCount        = 3;
    self.tranformFadeViewOne.horizontalCount      = 12;
    self.tranformFadeViewOne.center               = self.contentView.center;
    self.tranformFadeViewOne.fadeDuradtion        = 1.f;
    self.tranformFadeViewOne.animationGapDuration = 0.075f;
    [self.tranformFadeViewOne buildMaskView];
    [self.contentView addSubview:self.tranformFadeViewOne];
    
    // 图片2
    self.tranformFadeViewTwo                      = [[TranformFadeView alloc] initWithFrame:self.contentView.bounds];
    self.tranformFadeViewTwo.contentMode          = UIViewContentModeScaleAspectFill;
    self.tranformFadeViewTwo.verticalCount        = 3;
    self.tranformFadeViewTwo.horizontalCount      = 12;
    self.tranformFadeViewTwo.center               = self.contentView.center;
    self.tranformFadeViewTwo.fadeDuradtion        = 1.f;
    self.tranformFadeViewTwo.animationGapDuration = 0.075f;
    [self.tranformFadeViewTwo buildMaskView];
    [self.contentView addSubview:self.tranformFadeViewTwo];
    [self.tranformFadeViewTwo fadeAnimated:NO];

    // timer
    __weak typeof(self) weakSelf = self;
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        [weakSelf timerEvent];
        
    } timeIntervalWithSecs:8 delaySecs:1.f];
    [self.timer start];
}

- (void)timerEvent {

    if (self.type == kTypeOne) {
        
        self.type = kTypeTwo;
        
        [self.contentView sendSubviewToBack:self.tranformFadeViewTwo];
        self.tranformFadeViewTwo.image = [self currentImage];
        [self.tranformFadeViewTwo showAnimated:NO];
        [self.tranformFadeViewOne fadeAnimated:YES];
        
    } else {
        
        self.type = kTypeOne;
        
        [self.contentView sendSubviewToBack:self.tranformFadeViewOne];
        self.tranformFadeViewOne.image = [self currentImage];
        [self.tranformFadeViewOne showAnimated:NO];
        [self.tranformFadeViewTwo fadeAnimated:YES];
    }
}

- (UIImage *)currentImage {

    self.count = ++self.count % self.images.count;
    
    return self.images[self.count];
}

@end
