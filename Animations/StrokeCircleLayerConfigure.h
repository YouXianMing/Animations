//
//  StrokeCircleLayerConfigure.h
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CAShapeLayerConfigure.h"

@interface StrokeCircleLayerConfigure : CAShapeLayerConfigure

@property (nonatomic) CGPoint   circleCenter;
@property (nonatomic) CGFloat   radius;
@property (nonatomic) CGFloat   startAngle;
@property (nonatomic) CGFloat   endAngle;
@property (nonatomic) BOOL      clockWise;

@end
