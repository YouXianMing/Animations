//
//  BaseCustomViewController.h
//  BaseStructrue
//
//  Created by YouXianMing on 2017/5/15.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowLoadingView.h"
#import "ControllerBaseViewConfig.h"
@class BaseCustomViewController;

@protocol BaseCustomViewControllerDelegate <NSObject>

@optional

/**
 The BaseCustomViewController's event.

 @param controller The kind of BaseCustomViewController.
 @param event The event.
 */
- (void)baseCustomViewController:(__kindof BaseCustomViewController *)controller event:(id)event;

@end

@interface BaseCustomViewController : UIViewController

extern NSString * const windowAreaViewId;
extern NSString * const loadingAreaViewId;
extern NSString * const titleViewId;
extern NSString * const contentViewId;
extern NSString * const backgroundViewId;

/**
 The BaseCustomViewController's delegate.
 */
@property (nonatomic, weak) id <BaseCustomViewControllerDelegate> customViewControllerDelegate;

//  level            view                frame
//  ---------------------------------------------------------------
//
//  highest          windowAreaView      0 x  0 x width x height
//
//  higher           loadingAreaView     0 x 64 x width x (height - 64)
//
//  high             titleView           0 x  0 x width x 64
//
//  high             contentView         0 x 64 x width x (height - 64)
//
//  normal           backgroundView      0 x  0 x width x height
//

@property (nonatomic, strong) ShowLoadingView  *windowAreaView;
@property (nonatomic, strong) ShowLoadingView  *loadingAreaView;
@property (nonatomic, strong) UIView           *titleView;
@property (nonatomic, strong) UIView           *contentView;
@property (nonatomic, strong) UIView           *backgroundView;

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

#pragma mark - Overwrite by subClass.

/**
 *  Overwrite to config subViews.
 *
 *  @param viewsConfig Configs.
 */
- (void)makeViewsConfig:(NSMutableDictionary <NSString *, ControllerBaseViewConfig *> *)viewsConfig;

/**
 *  Overwrite to setup titleView, contentView etc.
 */
- (void)setupSubViews;

@end
