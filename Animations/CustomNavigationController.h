//
//  CustomNavigationController.h
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomViewController.h"

@interface CustomNavigationController : UINavigationController

/**
 *  Init with rootViewController.
 *
 *  @param rootViewController An UIViewController used as rootViewController.
 *  @param hidden             Navigation bar hide or not.
 *
 *  @return CustomNavigationController object.
 */
- (instancetype)initWithRootViewController:(BaseCustomViewController *)rootViewController setNavigationBarHidden:(BOOL)hidden;

@end
