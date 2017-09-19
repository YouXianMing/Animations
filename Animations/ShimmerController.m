//
//  ShimmerController.m
//  Animations
//
//  Created by YouXianMing on 15/12/18.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "ShimmerController.h"
#import "UIView+SetRect.h"
#import "FBShimmeringLayer.h"
#import "FBShimmeringView.h"
#import "StrokeCircleLayerConfigure.h"
#import "UIFont+Fonts.h"

@interface ShimmerController ()

@end

@implementation ShimmerController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    {
        FBShimmeringView *shimmeringView           = [[FBShimmeringView alloc] initWithFrame:self.contentView.bounds];
        shimmeringView.shimmering                  = YES;
        shimmeringView.shimmeringBeginFadeDuration = 0.3;
        shimmeringView.shimmeringOpacity           = 0.3;
        [self.contentView addSubview:shimmeringView];
        
        UILabel *logoLabel         = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
        logoLabel.text             = @"Shimmer";
        logoLabel.font             = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60.0];
        logoLabel.textColor        = [UIColor whiteColor];
        logoLabel.textAlignment    = NSTextAlignmentCenter;
        logoLabel.backgroundColor  = [UIColor clearColor];
        shimmeringView.contentView = logoLabel;
    }
    
    {
        FBShimmeringLayer *shimmeringLayer          = [FBShimmeringLayer layer];
        shimmeringLayer.frame                       = (CGRect){CGPointZero, CGSizeMake((130 + 1) * 2, (130 + 1) * 2)};
        shimmeringLayer.position                    = self.contentView.center;
        shimmeringLayer.shimmering                  = YES;
        shimmeringLayer.shimmeringBeginFadeDuration = 0.3;
        shimmeringLayer.shimmeringOpacity           = 0.3;
        shimmeringLayer.shimmeringPauseDuration     = 0.6f;
        [self.contentView.layer addSublayer:shimmeringLayer];
        
        CAShapeLayer *circleShape          = [CAShapeLayer layer];
        StrokeCircleLayerConfigure *config = [StrokeCircleLayerConfigure new];
        config.lineWidth                   = 1.f;
        config.startAngle                  = 0;
        config.endAngle                    = M_PI * 2;
        config.radius                      = 130.f;
        config.strokeColor                 = [UIColor redColor];
        [config configCAShapeLayer:circleShape];
        
        shimmeringLayer.contentLayer = circleShape;
    }
}

- (void)setupSubViews {
    
    [super setupSubViews];
    
    // Title label.
    UILabel *titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 64.f)];
    titleLabel.font          = [UIFont HeitiSCWithFontSize:20.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor     = [UIColor cyanColor];
    titleLabel.text          = self.title;
    
    FBShimmeringView *shimmeringView           = [[FBShimmeringView alloc] initWithFrame:titleLabel.bounds];
    shimmeringView.shimmering                  = YES;
    shimmeringView.shimmeringBeginFadeDuration = 0.3;
    shimmeringView.shimmeringOpacity           = 0.1f;
    shimmeringView.shimmeringAnimationOpacity  = 1.f;
    shimmeringView.bottom                      = self.titleView.height;
    shimmeringView.contentView                 = titleLabel;
    [self.titleView addSubview:shimmeringView];
    
    // Line.
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleView.height - 0.5, self.view.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.titleView addSubview:line];
    
    // Back button.
    UIImage  *image      = [UIImage imageNamed:@"backIconVer2"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center    = CGPointMake(20, shimmeringView.centerY);
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

@end
