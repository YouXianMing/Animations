//
//  CustomViewController.h
//  Animations
//
//  Created by YouXianMing on 2017/10/24.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomViewController;

@protocol CustomViewControllerDelegate <NSObject>

@optional

/**
 *  The BaseCustomViewController's event.
 *
 *  @param controller Kind of BaseCustomViewController.
 *  @param event The event.
 */
- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event;

@end

@interface CustomViewController : UIViewController

/**
 *  The BaseCustomViewController's delegate.
 */
@property (nonatomic, weak) id <CustomViewControllerDelegate> eventDelegate;

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
