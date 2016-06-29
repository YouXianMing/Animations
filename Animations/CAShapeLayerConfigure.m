//
//  CAShapeLayerConfigure.m
//  Animations
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CAShapeLayerConfigure.h"

@implementation CAShapeLayerConfigure

- (void)configCAShapeLayer:(CAShapeLayer *)shapeLayer {
    
    shapeLayer.lineWidth   = self.lineWidth;
    shapeLayer.strokeColor = (self.strokeColor.CGColor == nil ? [UIColor whiteColor].CGColor : self.strokeColor.CGColor);
    shapeLayer.fillColor   = (self.fillColor.CGColor   == nil ? [UIColor blackColor].CGColor : self.fillColor.CGColor);
}

@end
