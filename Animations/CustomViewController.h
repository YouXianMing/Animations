//
//  CustomViewController.h
//  Animations
//
//  Created by YouXianMing on 15/11/17.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessViewTagProtocol.h"

@interface CustomViewController : UIViewController <AccessViewTagProtocol>

/**
 *  Screen's width.
 */
@property (nonatomic) CGFloat  width;

/**
 *  Screen's height.
 */
@property (nonatomic) CGFloat  height;

/**
 *  Base config.
 */
- (void)setup;

/**
 *  You can only use this method when the current controller is an UINavigationController's rootViewController.
 */
- (void)useInteractivePopGestureRecognizer;

/**
 *  You can use this property when this controller is pushed by an UINavigationController.
 */
@property (nonatomic)  BOOL  enableInteractivePopGestureRecognizer;

/**
 *  If this controller is managed by an UINavigationController, you can use this method to pop.
 *
 *  @param animated Animated or not.
 */
- (void)popViewControllerAnimated:(BOOL)animated;

/**
 *  If this controller is managed by an UINavigationController, you can use this method to pop to the rootViewController.
 *
 *  @param animated Animated or not.
 */
- (void)popToRootViewControllerAnimated:(BOOL)animated;

@end
