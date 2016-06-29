//
//  InfiniteRotationView.h
//  InfiniteRotationView
//
//  Created by YouXianMing on 16/1/13.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfiniteRotationView : UIView

/**
 *  How many seconds to rotate 1 π (s/π).
 */
@property (nonatomic) NSTimeInterval  speed;

/**
 *  Direction of rotation, default is YES.
 */
@property (nonatomic) BOOL    clockWise;

/**
 *  Start angle.
 */
@property (nonatomic) CGFloat startAngle;

/**
 *  Start rotate animation.
 */
- (void)startRotateAnimation;

/**
 *  Stop and reset animation.
 */
- (void)reset;

@end
