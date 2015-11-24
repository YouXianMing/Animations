//
//  CustomTitleViewController.m
//  Animations
//
//  Created by YouXianMing on 15/11/24.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomTitleViewController.h"
#import "UIView+SetRect.h"
#import "UIColor+CustomColors.h"

@interface CustomTitleViewController ()

@end

@implementation CustomTitleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createTitleView];
}

- (void)createTitleView {

    // Title view.
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    [self.view addSubview:self.titleView];
    
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = Font_Avenir(20.f);
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [UIColor customGrayColor];
    headlinelabel.text          = self.title;
    [headlinelabel sizeToFit];
    
    headlinelabel.center = self.titleView.middlePoint;
    
    // Line.
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, self.view.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.titleView addSubview:line];
    [self.titleView addSubview:headlinelabel];
    
    // Back button.
    UIImage  *image      = [UIImage imageNamed:@"backIcon"];
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

- (void)bringTitleViewToFront {

    [self.view bringSubviewToFront:self.titleView];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    self.enableInteractivePopGestureRecognizer = NO;
}

@end
