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

    self.lineWidth   = 0.f;
    self.strokeColor = [UIColor clearColor];
    
    [super configCAShapeLayer:shapeLayer];
    
    shapeLayer.bounds   = CGRectMake(0, 0, (self.lineWidth + self.radius) * 2, (self.lineWidth + self.radius) * 2);
    shapeLayer.position = self.circleCenter;
    UIBezierPath *path  = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.lineWidth + self.radius, self.lineWidth + self.radius)
                                                         radius:self.radius + self.lineWidth / 2.f
                                                     startAngle:self.startAngle
                                                       endAngle:self.endAngle
                                                      clockwise:self.clockWise];
    
    shapeLayer.path = path.CGPath;
}


@end
