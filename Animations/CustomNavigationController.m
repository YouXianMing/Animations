//
//  CustomNavigationController.m
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomNavigationController.h"

@implementation CustomNavigationController

- (instancetype)initWithRootViewController:(CustomViewController *)rootViewController setNavigationBarHidden:(BOOL)hidden {

    CustomNavigationController *ncController = [[[self class] alloc] initWithRootViewController:rootViewController];
    [ncController setNavigationBarHidden:hidden animated:NO];
    [rootViewController useInteractivePopGestureRecognizer];
    
    return ncController;
}

@end
