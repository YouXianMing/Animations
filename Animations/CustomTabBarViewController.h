//
//  CustomTabBarViewController.h
//  TotalCustomTabBarController
//
//  Created by YouXianMing on 16/6/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomViewController.h"
#import "AccessViewTagProtocol.h"
@class CustomTabBarViewController;

@protocol CustomTabBarViewControllerDelegate <NSObject, AccessViewTagProtocol>

@optional

- (BOOL)customTabBarController:(CustomTabBarViewController *)tabBarController
    shouldSelectViewController:(UIViewController *)viewController
                 selectedIndex:(NSInteger)index;

- (void)customTabBarController:(CustomTabBarViewController *)tabBarController
       didSelectViewController:(UIViewController *)viewController
                 selectedIndex:(NSInteger)index;

@end

@interface CustomTabBarViewController : CustomViewController

/**
 *  CustomTabBarViewController's delegate.
 */
@property (nonatomic, weak) id <CustomTabBarViewControllerDelegate> delegate;

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
@property(nonatomic, strong) NSArray <__kindof CustomViewController *> *viewControllers;

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
 *  Build items in the tabBarView.
 */
- (void)buildItems;

@end
