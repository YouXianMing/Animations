//
//  CustomTabBarViewController.h
//  TotalCustomTabBarController
//
//  Created by YouXianMing on 16/6/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BaseCustomViewController.h"
@class CustomTabBarViewController;

@protocol CustomTabBarViewControllerDelegate <NSObject>

@optional

- (BOOL)customTabBarController:(CustomTabBarViewController *)tabBarController
    shouldSelectViewController:(UIViewController *)viewController
                 selectedIndex:(NSInteger)index;

- (void)customTabBarController:(CustomTabBarViewController *)tabBarController
       didSelectViewController:(UIViewController *)viewController
                 selectedIndex:(NSInteger)index;

@end

@interface CustomTabBarViewController : BaseCustomViewController

/**
 *  CustomTabBarViewController's delegate.
 */
@property (nonatomic, weak) id <CustomTabBarViewControllerDelegate> tabBarViewControllerDelegate;

/**
 *  TabBar's height, default is 49.f.
 */
@property (nonatomic) CGFloat tabBarHeight;

/**
 *  The controller's index that loaded and show by CustomTabBarViewController at the first time.
 */
@property (nonatomic) NSInteger  firstLoadIndex;

/**
 *  ViewControllers.
 */
@property(nonatomic, strong) NSMutableArray <UIViewController *> *viewControllers;

/**
 *  Hide TabBarView or not.
 *
 *  @param hide     Hide or not.
 *  @param animated Animated or not.
 */
- (void)hideTabBarView:(BOOL)hide animated:(BOOL)animated;

#pragma mark - Used by subClass.

/**
 *  TabBarView, you should add view on it.
 */
@property (nonatomic, strong, readonly) UIView  *tabBarView;

/**
 *  Will select index, used by subClass.
 *
 *  @param index Index.
 *
 *  @return Will selected or not.
 */
- (BOOL)willSelectIndex:(NSInteger)index;

/**
 *  Did selected index, used by subClass.
 *
 *  @param index Index.
 */
- (void)didSelectedIndex:(NSInteger)index;

/**
 [Overwrite by subClass] Add childViewControllers.
 
 @param controllers UIViewController数组
 */
- (void)addChildViewControllers:(NSMutableArray <UIViewController *> *)controllers;

/**
 *  [Overwrite by subClass] Build items on TabBarView.
 */
- (void)buildItems;

@end
