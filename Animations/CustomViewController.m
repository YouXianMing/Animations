//
//  CustomViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/10/24.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController () <UIGestureRecognizerDelegate>

@end

@implementation CustomViewController

- (void)useInteractivePopGestureRecognizer {
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)popViewControllerAnimated:(BOOL)animated {
    
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated {
    
    [self.navigationController popToRootViewControllerAnimated:animated];
}

- (void)dealloc {
        
#ifdef DEBUG
    
    printf("[⚠️] Did released the %s.\n", NSStringFromClass(self.class).UTF8String);
    
#endif
}

#pragma mark - Overwrite setter & getter.

@synthesize enableInteractivePopGestureRecognizer = _enableInteractivePopGestureRecognizer;

- (void)setEnableInteractivePopGestureRecognizer:(BOOL)enableInteractivePopGestureRecognizer {
    
    _enableInteractivePopGestureRecognizer                            = enableInteractivePopGestureRecognizer;
    self.navigationController.interactivePopGestureRecognizer.enabled = enableInteractivePopGestureRecognizer;
}

- (BOOL)enableInteractivePopGestureRecognizer {
    
    return _enableInteractivePopGestureRecognizer;
}

@end
