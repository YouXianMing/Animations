//
//  CustomVisualEffectTitleViewController.h
//  Animations
//
//  Created by YouXianMing on 15/11/24.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomVisualEffectTitleViewController : CustomViewController

/**
 *  Title view.
 */
@property (nonatomic, strong) UIView  *titleView;

/**
 *  Create TitleView.
 */
- (void)createTitleView;

/**
 *  Bring TitleView to front.
 */
- (void)bringTitleViewToFront;

@end
