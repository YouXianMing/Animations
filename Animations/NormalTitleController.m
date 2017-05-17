//
//  NormalTitleController.m
//  Animations
//
//  Created by YouXianMing on 2017/5/17.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "NormalTitleController.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"

@interface NormalTitleController ()

@end

@implementation NormalTitleController

- (void)setupSubViews {
    
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = [UIFont HeitiSCWithFontSize:20.f];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [UIColor colorWithRed:0.329  green:0.329  blue:0.329 alpha:1];
    headlinelabel.text          = self.title;
    [headlinelabel sizeToFit];
    
    headlinelabel.center = self.titleView.middlePoint;
    
    // Line.
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, self.view.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.titleView addSubview:line];
    [self.titleView addSubview:headlinelabel];
    
    // Back button.
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center    = CGPointMake(20, self.titleView.middleY);
    [backButton setImage:[UIImage imageNamed:@"backIcon"]             forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backIcon_highlighted"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

@end
