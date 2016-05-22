//
//  CustomViewController.h
//  Animations
//
//  Created by YouXianMing on 15/11/17.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomViewController : UIViewController

/**
 *  Set the view whose tag matches the specified value.
 *
 *  @param view      View.
 *  @param tagString String.
 */
- (void)setView:(UIView *)view withTagString:(NSString *)tagString;

/**
 *  Get the view from the tagString.
 *
 *  @param tagString String.
 *
 *  @return view.
 */
- (id)viewWithTagSting:(NSString *)tagString;

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
