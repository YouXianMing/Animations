//
//  ColorProgressViewController.m
//  Animations
//
//  Created by YouXianMing on 16/1/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ColorProgressViewController.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "ColorProgressView.h"
#import "ProgressColor+Colors.h"
#import "GCD.h"

@interface ColorProgressViewController ()

@property (nonatomic, strong) GCDTimer           *timer;
@property (nonatomic, strong) ColorProgressView  *normalColorProgressView;
@property (nonatomic, strong) ColorProgressView  *redColorProgressView;

@end

@implementation ColorProgressViewController

- (void)setup {
    
    [super setup];
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    {
        self.normalColorProgressView        = [[ColorProgressView alloc] initWithFrame:CGRectMake(0, 0, Width, 1)];
        self.normalColorProgressView.center = self.contentView.middlePoint;
        self.normalColorProgressView.y     -= 20;
        [self.normalColorProgressView startAnimation];
        [self.contentView addSubview:self.normalColorProgressView];
    }
    
    {
        self.redColorProgressView        = [[ColorProgressView alloc] initWithFrame:CGRectMake(0, 0, Width, 1)];
        self.redColorProgressView.center = self.contentView.middlePoint;
        self.redColorProgressView.y     += 20;
        self.redColorProgressView.color  = [ProgressColor redGradientColor];
        [self.redColorProgressView startAnimation];
        [self.contentView addSubview:self.redColorProgressView];
    }
    
    _md_get_weakSelf();
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:2 initialSpringVelocity:0 options:0 animations:^{
            
            weakSelf.normalColorProgressView.progress = arc4random() % 101 / 100.f;
            weakSelf.redColorProgressView.progress    = arc4random() % 101 / 100.f;
            
        } completion:nil];
        
    } timeIntervalWithSecs:1.f delaySecs:1.f];
    [self.timer start];
}

/**
 *  Overwrite buildTitleView method.
 */
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
