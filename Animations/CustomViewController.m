//
//  CustomViewController.m
//  Animations
//
//  Created by YouXianMing on 15/11/17.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomViewController.h"
#import <asl.h>

#define _Flag_NSLog(fmt,...) {                                        \
  do                                                                  \
  {                                                                   \
    NSString *str = [NSString stringWithFormat:fmt, ##__VA_ARGS__];   \
    printf("%s\n",[str UTF8String]);                                  \
    asl_log(NULL, NULL, ASL_LEVEL_NOTICE, "%s", [str UTF8String]);    \
  }                                                                   \
  while (0);                                                          \
}

#ifdef DEBUG
#define ControllerLog(fmt, ...) _Flag_NSLog((@"" fmt), ##__VA_ARGS__)
#else
#define ControllerLog(...)
#endif

@interface CustomViewController () <UIGestureRecognizerDelegate>

@end

@implementation CustomViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setup];
}

- (void)setup {

    self.width                = [UIScreen mainScreen].bounds.size.width;
    self.height               = [UIScreen mainScreen].bounds.size.height;
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

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
#ifdef DEBUG
    
    [self debugMessage];
    
#endif
}

#pragma mark - 重写setter,getter方法

@synthesize enableInteractivePopGestureRecognizer = _enableInteractivePopGestureRecognizer;

- (void)setEnableInteractivePopGestureRecognizer:(BOOL)enableInteractivePopGestureRecognizer {
    
    _enableInteractivePopGestureRecognizer                            = enableInteractivePopGestureRecognizer;
    self.navigationController.interactivePopGestureRecognizer.enabled = enableInteractivePopGestureRecognizer;
}

- (BOOL)enableInteractivePopGestureRecognizer {
    
    return _enableInteractivePopGestureRecognizer;
}

#pragma mark - Debug message.

- (void)debugMessage {
    
    NSString        *classString = [NSString stringWithFormat:@" %@ ", [self class]];
    NSMutableString *flagString  = [NSMutableString string];
    
    for (int i = 0; i < classString.length; i++) {
        
        if (i == 0 || i == classString.length - 1) {
            
            [flagString appendString:@"+"];
            continue;
        }
        
        [flagString appendString:@"-"];
    }
    
    NSString *showSting = [NSString stringWithFormat:@"\n%@\n%@\n%@\n", flagString, classString, flagString];
    ControllerLog(@"%@", showSting);
}

@end
