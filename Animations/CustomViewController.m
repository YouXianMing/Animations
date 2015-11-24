//
//  CustomViewController.m
//  Animations
//
//  Created by YouXianMing on 15/11/17.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController () <UIGestureRecognizerDelegate>

@end

@implementation CustomViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setup];
}

- (void)setup {

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)useInteractivePopGestureRecognizer {
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)popViewControllerAnimated:(BOOL)animated {

    [self.navigationController popViewControllerAnimated:animated];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated {

    [self.navigationController popToRootViewControllerAnimated:animated];
}

#pragma mark - 重写setter,getter方法
@synthesize enableInteractivePopGestureRecognizer = _enableInteractivePopGestureRecognizer;
- (void)setEnableInteractivePopGestureRecognizer:(BOOL)enableInteractivePopGestureRecognizer {
    
    _enableInteractivePopGestureRecognizer = enableInteractivePopGestureRecognizer;
    self.navigationController.interactivePopGestureRecognizer.enabled = enableInteractivePopGestureRecognizer;
}

- (BOOL)enableInteractivePopGestureRecognizer {
    
    return _enableInteractivePopGestureRecognizer;
}

@end
