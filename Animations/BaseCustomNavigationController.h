//
//  BaseCustomNavigationController.h
//  PersonalLibs
//
//  Created by YouXianMing on 2017/6/25.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomViewController.h"

@interface BaseCustomNavigationController : UINavigationController

/**
 Get the BaseCustomNavigationController with the root BaseCustomViewController.

 @param rootViewController The root BaseCustomViewController.
 @param hidden Hidden or not.
 @return BaseCustomNavigationController object.
 */
- (instancetype)initWithRootViewController:(BaseCustomViewController *)rootViewController
                    setNavigationBarHidden:(BOOL)hidden;

@end
