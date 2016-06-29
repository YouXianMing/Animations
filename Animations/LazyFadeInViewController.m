//
//  LazyFadeInViewController.m
//  Animations
//
//  Created by YouXianMing on 16/4/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LazyFadeInViewController.h"
#import "LazyFadeInView.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "GCD.h"

@interface LazyFadeInViewController () <LazyFadeInViewDelegate>

@property (strong, nonatomic) LazyFadeInView *fadeInView;

@end

@implementation LazyFadeInViewController

- (void)setup {

    [super setup];
    
    // https://github.com/itouch2/LazyFadeInView
    
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    self.fadeInView           = [[LazyFadeInView alloc] initWithFrame:CGRectMake(20, 20, Width - 40, self.contentView.height - 40)];
    self.fadeInView.delegate  = self;
    self.fadeInView.textColor = [UIColor whiteColor];
    self.fadeInView.text      = @"夫君子之行，静以修身，俭以养德。非淡泊无以明志，非宁静无以致远。夫学须静也，才须学也。非学无以广才，非志无以成学。韬慢则不能励精，险躁则不能冶性。年与时驰，意与日去，遂成枯落，多不接世。悲守穷庐，将复何及？";
    self.fadeInView.textFont  = [UIFont HeitiSCWithFontSize:14.f];
    [self.contentView addSubview:self.fadeInView];
}

- (void)fadeInAnimationDidEnd:(LazyFadeInView *)fadeInView {
    
    NSLog(@"%@ fade in animation completed.", fadeInView);
}

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
