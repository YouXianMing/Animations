//
//  UIViewController+Status.h
//  Animations
//
//  Created by YouXianMing on 2017/7/31.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Status)

/**
 To check, that this controller is pushed from NavigationController.

 @return Is pushed from NavigationController or not.
 */
- (BOOL)isPushedFromNavigationController;

@end
