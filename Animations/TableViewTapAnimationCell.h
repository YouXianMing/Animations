//
//  TableViewTapAnimationCell.h
//  Animations
//
//  Created by YouXianMing on 15/11/27.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomAdapterTypeCell.h"

@interface TableViewTapAnimationCell : CustomAdapterTypeCell

/**
 *  Show selected animation.
 */
- (void)showSelectedAnimation;

/**
 *  Change cell's state.
 *
 *  @param animated Animated or not.
 */
- (void)changeStateAnimated:(BOOL)animated;

@end
