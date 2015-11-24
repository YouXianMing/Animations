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
    
    TYPE_ONE,
    TYPE_TWO,
    
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

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)setup {

    [super setup];
    
    self.images = @[[UIImage imageNamed:@"1"],
                    [UIImage imageNamed:@"2"],
                    [UIImage imageNamed:@"3"],
                    [UIImage imageNamed:@"4"],
                    [UIImage imageNamed:@"5"]];
    
    // 图片1
    self.tranformFadeViewOne                 = [[TranformFadeView alloc] initWithFrame:self.view.bounds];
    self.tranformFadeViewOne.contentMode     = UIViewContentModeScaleAspectFill;
    self.tranformFadeViewOne.image           = [self currentImage];
    self.tranformFadeViewOne.verticalCount   = 2;
    self.tranformFadeViewOne.horizontalCount = 12;
    self.tranformFadeViewOne.center          = self.view.center;
    [self.tranformFadeViewOne buildMaskView];
    
    self.tranformFadeViewOne.fadeDuradtion        = 1.f;
    self.tranformFadeViewOne.animationGapDuration = 0.1f;
    
    [self.view addSubview:self.tranformFadeViewOne];
    
    
    // 图片2
    self.tranformFadeViewTwo                 = [[TranformFadeView alloc] initWithFrame:self.view.bounds];
    self.tranformFadeViewTwo.contentMode     = UIViewContentModeScaleAspectFill;
    self.tranformFadeViewTwo.verticalCount   = 2;
    self.tranformFadeViewTwo.horizontalCount = 12;
    self.tranformFadeViewTwo.center          = self.view.center;
    [self.tranformFadeViewTwo buildMaskView];
    
    self.tranformFadeViewTwo.fadeDuradtion        = 1.f;
    self.tranformFadeViewTwo.animationGapDuration = 0.1f;
    
    [self.view addSubview:self.tranformFadeViewTwo];
    [self.tranformFadeViewTwo fadeAnimated:YES];

    // timer
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        if (self.type == TYPE_ONE) {
            
            self.type = TYPE_TWO;
            
            [self.view sendSubviewToBack:self.tranformFadeViewTwo];
            self.tranformFadeViewTwo.image = [self currentImage];
            [self.tranformFadeViewTwo showAnimated:NO];
            [self.tranformFadeViewOne fadeAnimated:YES];
            
        } else {
            
            self.type = TYPE_ONE;
            
            [self.view sendSubviewToBack:self.tranformFadeViewOne];
            self.tranformFadeViewOne.image = [self currentImage];
            [self.tranformFadeViewOne showAnimated:NO];
            [self.tranformFadeViewTwo fadeAnimated:YES];
        }
        
    } timeIntervalWithSecs:6];
    [self.timer start];
    
    [self bringTitleViewToFront];
}

- (UIImage *)currentImage {

    self.count = ++self.count % self.images.count;
    
    return self.images[self.count];
}

@end
