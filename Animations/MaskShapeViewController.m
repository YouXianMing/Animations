//
//  MaskShapeViewController.m
//  Animations
//
//  Created by YouXianMing on 16/7/10.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "MaskShapeViewController.h"
#import "AppleSystemService.h"
#import "JSAnimatedImagesView.h"
#import "CutOutClearView.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "FBShimmeringView.h"

typedef enum : NSUInteger {
    
    kUpJsView = 1000,
    kDownJsView,
    
} EMaskShapeViewControllerValue;

@interface MaskShapeViewController () <JSAnimatedImagesViewDataSource>

@property (nonatomic, strong) JSAnimatedImagesView  *upJsView;
@property (nonatomic, strong) NSArray               *upDataSource;

@property (nonatomic, strong) JSAnimatedImagesView  *downJsView;
@property (nonatomic, strong) NSArray               *downDataSource;

@end

@implementation MaskShapeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    CGFloat gap    = 4.f;
    CGFloat offset = 50.f;
    
    {
        CutOutClearView *areaView = [[CutOutClearView alloc] initWithFrame:CGRectMake(0, 0, Width, self.contentView.height / 2.f + offset - gap)];
        areaView.fillColor        = [UIColor clearColor];
        areaView.areaColor        = [UIColor blackColor];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(gap, gap)];
        [path addLineToPoint:CGPointMake(Width - gap, gap)];
        [path addLineToPoint:CGPointMake(Width - gap, areaView.height)];
        [path addLineToPoint:CGPointMake(gap, areaView.height - (offset - gap) * 2 - gap)];
        [path closePath];
        areaView.paths = @[path];
        
        self.upDataSource = @[[UIImage imageNamed:@"1"],
                              [UIImage imageNamed:@"2"],
                              [UIImage imageNamed:@"3"],
                              [UIImage imageNamed:@"4"],
                              [UIImage imageNamed:@"5"]];
        
        self.upJsView                     = [[JSAnimatedImagesView alloc] initWithFrame:CGRectMake(0, 0, Width, self.contentView.height / 2.f + offset - gap)];
        self.upJsView.transitionDuration  = 2.f;
        self.upJsView.tag                 = kUpJsView;
        self.upJsView.dataSource          = self;
        self.upJsView.layer.masksToBounds = YES;
        self.upJsView.maskView            = areaView;
        [self.contentView addSubview:self.upJsView];
    }
    
    {
        CutOutClearView *areaView = [[CutOutClearView alloc] initWithFrame:CGRectMake(0, 0, Width, self.contentView.height / 2.f + (offset - gap))];
        areaView.fillColor        = [UIColor clearColor];
        areaView.areaColor        = [UIColor blackColor];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(gap, 0)];
        [path addLineToPoint:CGPointMake(gap, areaView.height - gap)];
        [path addLineToPoint:CGPointMake(Width - gap, areaView.height - gap)];
        [path addLineToPoint:CGPointMake(Width - gap, (offset - gap) * 2 + gap)];
        [path closePath];
        areaView.paths = @[path];
        
        self.downDataSource = @[[UIImage imageNamed:@"pic_1"],
                                [UIImage imageNamed:@"pic_2"],
                                [UIImage imageNamed:@"pic_3"],
                                [UIImage imageNamed:@"pic_4"]];
        
        self.downJsView                     = [[JSAnimatedImagesView alloc] initWithFrame:CGRectMake(0, 0, Width, self.contentView.height / 2.f + offset - gap)];
        self.downJsView.transitionDuration  = 2.f;
        self.downJsView.tag                 = kDownJsView;
        self.downJsView.dataSource          = self;
        self.downJsView.layer.masksToBounds = YES;
        self.downJsView.maskView            = areaView;
        
        self.downJsView.bottom = self.contentView.height;
        [self.contentView addSubview:self.downJsView];
    }
}

#pragma mark - JSAnimatedImagesViewDataSource

- (NSUInteger)animatedImagesNumberOfImages:(JSAnimatedImagesView *)animatedImagesView {
    
    NSUInteger count = 0;
    animatedImagesView.tag == kUpJsView ? (count = self.upDataSource.count) : (count = self.downDataSource.count);
    
    return count;
}

- (UIImage *)animatedImagesView:(JSAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index {
    
    UIImage *image = nil;
    animatedImagesView.tag == kUpJsView ? (image = self.upDataSource[index]) : (image = self.downDataSource[index]);
    
    return image;
}

#pragma mark - Overwrite methods.

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
