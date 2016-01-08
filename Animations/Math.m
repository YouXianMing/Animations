//
//  Math.m
//  MathEquation
//
//  Created by YouXianMing on 15/11/20.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "Math.h"

@implementation Math

+ (CGFloat)degreeFromRadian:(CGFloat)radian {

    return ((radian) * (180.0 / M_PI));
}

+ (CGFloat)radianFromDegree:(CGFloat)degree {

    return ((degree) * M_PI / 180.f);
}

+ (CGFloat)radianValueFromTanSideA:(CGFloat)sideA sideB:(CGFloat)sideB {

    return atan2f(sideA, sideB);
}

CGFloat calculateSlope(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2) {
    
    if (x2 == x1) {
        
        return 0;
    }
    
    return (y2 - y1) / (x2 - x1);
}

CGFloat calculateConstant(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2) {
    
    if (x2 == x1) {
        
        return 0;
    }
    
    return (y1*(x2 - x1) - x1*(y2 - y1)) / (x2 - x1);
}

+ (instancetype)mathOnceLinearEquationWithPointA:(MATHPoint)pointA PointB:(MATHPoint)pointB {
    
    Math *equation = [[[self class] alloc] init];
    
    CGFloat x1 = pointA.x; CGFloat y1 = pointA.y;
    CGFloat x2 = pointB.x; CGFloat y2 = pointB.y;
    
    equation.k = calculateSlope(x1, y1, x2, y2);
    equation.b = calculateConstant(x1, y1, x2, y2);
    
    return equation;
}

- (CGFloat)xValueWhenYEqual:(CGFloat)yValue {
    
    if (_k == 0) {
        
        return 0;
    }
    
    return (yValue - _b) / _k;
}

- (CGFloat)yValueWhenXEqual:(CGFloat)xValue {
    
    return _k * xValue + _b;
}

+ (CGSize)resetFromSize:(CGSize)size withFixedWidth:(CGFloat)width {
    
    CGFloat newHeight = size.height * (width / size.width);
    CGSize  newSize   = CGSizeMake(width, newHeight);
    
    return newSize;
}

+ (CGSize)resetFromSize:(CGSize)size withFixedHeight:(CGFloat)height {
    
    float  newWidth = size.width * (height / size.height);
    CGSize newSize  = CGSizeMake(newWidth, height);
    
    return newSize;
}

@end
