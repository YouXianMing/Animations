//
//  CAShapeLayer+CornerRadius.h
//  UIImageRadius
//
//  Created by YouXianMing on 2016/11/28.
//  Copyright © 2016年 TechCode. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CAShapeLayer (CornerRadius)

+ (CAShapeLayer *)shapeLayerWithFrame:(CGRect)frame corners:(UIRectCorner)corners radius:(CGFloat)radius;

@end
