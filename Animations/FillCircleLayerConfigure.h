//
//  FillCircleLayerConfigure.h
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CAShapeLayerConfigure.h"

@interface FillCircleLayerConfigure : CAShapeLayerConfigure

/**
 *  CAShapeLayer's position.
 */
@property (nonatomic) CGPoint   circleCenter;

/**
 *  Circle radius.
 */
@property (nonatomic) CGFloat   radius;

/**
 *  Circle start angle, you can use 0.
 */
@property (nonatomic) CGFloat   startAngle;

/**
 *  Circle end angle, you can use M_PI.
 */
@property (nonatomic) CGFloat   endAngle;

/**
 *  ClockWise.
 */
@property (nonatomic) BOOL      clockWise;

@end
