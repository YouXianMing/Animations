//
//  CustomFullContentViewController.m
//  Animations
//
//  Created by YouXianMing on 15/12/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomFullContentViewController.h"

@interface CustomFullContentViewController ()

@end

@implementation CustomFullContentViewController

- (void)setup {
    
    [super setup];
    
    [self buildBackgroundView];
    [self buildContentView];
    [self buildTitleView];
    [self buildLoadingView];
    [self buildWindowView];
    
    self.loadingView.userInteractionEnabled = NO;
    self.windowView.userInteractionEnabled  = NO;
}

- (void)removeTitleView {

    if (self.titleView) {
        
        [self.titleView removeFromSuperview];
    }
}

- (void)buildBackgroundView {
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.view addSubview:self.backgroundView];
}

- (void)buildTitleView {
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 64)];
    [self.view addSubview:self.titleView];
}

- (void)buildContentView {
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.view addSubview:self.contentView];
}

- (void)buildLoadingView {
    
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.width, self.height - 64)];
    [self.view addSubview:self.loadingView];
}

- (void)buildWindowView {
    
    self.windowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.view addSubview:self.windowView];
}

@end
