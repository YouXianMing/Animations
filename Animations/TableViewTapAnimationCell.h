//
//  TableViewTapAnimationCell.h
//  Animations
//
//  Created by YouXianMing on 15/11/27.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CustomCell.h"

@interface TableViewTapAnimationCell : CustomCell

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
