//
//  UIView+CustomViewController.h
//  Animations
//
//  Created by YouXianMing on 16/6/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomViewController;

@interface UIView (CustomViewController)

/**
 *  Get the view with specified tag from CustomViewController type's controller.
 *
 *  @param tag        View's tag.
 *  @param controller CustomViewController's type.
 *
 *  @return The view.
 */
+ (instancetype)viewWithTag:(NSInteger)tag fromController:(CustomViewController *)controller;

/**
 *  Set the view's tag.
 *
 *  @param tag        View's tag.
 *  @param controller CustomViewController's type.
 */
- (void)setTag:(NSInteger)tag toController:(CustomViewController *)controller;

@end
