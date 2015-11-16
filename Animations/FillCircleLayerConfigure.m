//
//  FillCircleLayerConfigure.m
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "FillCircleLayerConfigure.h"

@implementation FillCircleLayerConfigure

- (void)configCAShapeLayer:(CAShapeLayer *)shapeLayer {

    self.lineWith    = 0.f;
    self.strokeColor = [UIColor clearColor];
    
    [super configCAShapeLayer:shapeLayer];
    
    shapeLayer.bounds   = CGRectMake(0, 0, (self.lineWith + self.radius) * 2, (self.lineWith + self.radius) * 2);
    shapeLayer.position = self.circleCenter;
    UIBezierPath *path  = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.lineWith + self.radius, self.lineWith + self.radius)
                                                         radius:self.radius + self.lineWith / 2.f
                                                     startAngle:self.startAngle
                                                       endAngle:self.endAngle
                                                      clockwise:self.clockWise];
    
    shapeLayer.path = path.CGPath;
}


@end
