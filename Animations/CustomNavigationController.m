//
//  CustomNavigationController.m
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:18.f]}];
    
    [self.navigationBar setBackgroundImage:[self imageWithFrame:CGRectMake(0, 0, 10, 10) backgroundColor:[[UIColor yellowColor] colorWithAlphaComponent:0.45f]]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setShadowImage:[self imageWithFrame:CGRectMake(0, 0, 10, 10) backgroundColor:[UIColor clearColor]]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //先进入子Controller
    [super pushViewController:viewController animated:animated];
    
    //替换掉leftBarButtonItem
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        
        viewController.navigationItem.leftBarButtonItem =[self customLeftBackButton];
    }
}

- (UIBarButtonItem *)customLeftBackButton {
    
    UIImage *image       = [UIImage imageNamed:@"backIcon"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

- (UIImage *)imageWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
    
    UIImage *image       = nil;
    UIView *view         = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    
    UIGraphicsBeginImageContext(view.frame.size);
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
