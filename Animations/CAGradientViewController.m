//
//  CAGradientViewController.m
//  Animations
//
//  Created by YouXianMing on 16/2/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CAGradientViewController.h"
#import "CAGradientMaskView.h"
#import "GCD.h"

typedef enum : NSUInteger {
    
    kTypeOne,
    kTypeTwo,
    
} EType;

@interface CAGradientViewController ()

@property (nonatomic, strong) NSArray   *images;
@property (nonatomic)         NSInteger  count;

@property (nonatomic, strong) CAGradientMaskView *tranformFadeViewOne;
@property (nonatomic, strong) CAGradientMaskView *tranformFadeViewTwo;

@property (nonatomic, strong) GCDTimer *timer;
@property (nonatomic)         EType     type;

@end

@implementation CAGradientViewController

- (void)setup {

    [super setup];
    
    self.images = @[[UIImage imageNamed:@"5"],
                    [UIImage imageNamed:@"1"],
                    [UIImage imageNamed:@"2"],
                    [UIImage imageNamed:@"3"],
                    [UIImage imageNamed:@"4"]];
        
    self.tranformFadeViewOne               = [[CAGradientMaskView alloc] initWithFrame:self.contentView.bounds];
    self.tranformFadeViewOne.contentMode   = UIViewContentModeScaleAspectFill;
    self.tranformFadeViewOne.fadeDuradtion = 4.f;
    self.tranformFadeViewOne.image         = [self currentImage];
    [self.contentView addSubview:self.tranformFadeViewOne];
    
    self.tranformFadeViewTwo               = [[CAGradientMaskView alloc] initWithFrame:self.contentView.bounds];
    self.tranformFadeViewTwo.contentMode   = UIViewContentModeScaleAspectFill;
    self.tranformFadeViewTwo.fadeDuradtion = 4.f;
    [self.contentView addSubview:self.tranformFadeViewTwo];
    [self.tranformFadeViewTwo fadeAnimated:NO];
    
    // timer
    _md_get_weakSelf();
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        [weakSelf timerEvent];
        
    } timeIntervalWithSecs:6 delaySecs:1.f];
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
