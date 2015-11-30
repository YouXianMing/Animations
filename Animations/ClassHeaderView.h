//
//  ClassHeaderView.h
//  HeaderViewTapAnimation
//
//  Created by YouXianMing on 15/9/16.
//  Copyright (c) 2015年 ZiPeiYi. All rights reserved.
//

#import "CustomHeaderFooterView.h"
#import "RotateView.h"

@interface ClassHeaderView : CustomHeaderFooterView

/**
 *  Change to normal state.
 *
 *  @param animated Animated or not.
 */
- (void)normalStateAnimated:(BOOL)animated;

/**
 *  Change to extended state.
 *
 *  @param animated Animated or not.
 */
- (void)extendStateAnimated:(BOOL)animated;

@end
