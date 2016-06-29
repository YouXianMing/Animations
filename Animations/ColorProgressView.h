//
//  ColorProgressView.h
//  Animations
//
//  Created by YouXianMing on 16/1/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressColor.h"

@interface ColorProgressView : UIView

/**
 *  Progress.
 */
@property (nonatomic) CGFloat  progress;

/**
 *  Progress color.
 */
@property (nonatomic, strong) ProgressColor  *color;

/**
 *  Start animation.
 */
- (void)startAnimation;

@end
