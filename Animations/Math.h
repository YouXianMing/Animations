//
//  Math.h
//  MathEquation
//
//  Created by YouXianMing on 15/11/20.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

struct MATHPoint {
    
    CGFloat x;
    CGFloat y;
    
}; typedef struct MATHPoint MATHPoint;

static inline MATHPoint MATHPointMake(CGFloat x, CGFloat y) {
    
    MATHPoint p; p.x = x; p.y = y; return p;
}

@interface Math : NSObject

#pragma mark - Radian & degree.

/**
 *  Convert radian to degree.
 *
 *  @param radian Radian.
 *
 *  @return Degree.
 */
+ (CGFloat)degreeFromRadian:(CGFloat)radian;

/**
 *  Convert degree to radian.
 *
 *  @param degree Degree.
 *
 *  @return radian.
 */
+ (CGFloat)radianFromDegree:(CGFloat)degree;

#pragma mark - Calculate radian.

/**
 *  Radian value from math 'tan' function.
 *
 *  @param sideA Side A
 *  @param sideB Side B
 *
 *  @return Radian value.
 */
+ (CGFloat)radianValueFromTanSideA:(CGFloat)sideA sideB:(CGFloat)sideB;

#pragma mark - Calculate once linear equation (Y = kX + b).

@property (nonatomic) CGFloat  k;
@property (nonatomic) CGFloat  b;

/**
 *  Calculate constant & slope by two math point for once linear equation.
 *
 *  @param pointA Point A.
 *  @param pointB Point B.
 *
 *  @return Math object.
 */
+ (instancetype)mathOnceLinearEquationWithPointA:(MATHPoint)pointA PointB:(MATHPoint)pointB;

/**
 *  Get X value when Y equal some number.
 *
 *  @param yValue Some number.
 *
 *  @return X number.
 */
- (CGFloat)xValueWhenYEqual:(CGFloat)yValue;

/**
 *  Get Y value when X equal some number.
 *
 *  @param xValue Some number.
 *
 *  @return Y number.
 */
- (CGFloat)yValueWhenXEqual:(CGFloat)xValue;

#pragma mark - Reset size.

/**
 *  Get the new size with the fixed width.
 *
 *  @param size  Old size.
 *  @param width The fixed width.
 *
 *  @return New size.
 */
+ (CGSize)resetFromSize:(CGSize)size withFixedWidth:(CGFloat)width;

/**
 *  Get the new size with the fixed height.
 *
 *  @param size   Old size.
 *  @param height The fixed width.
 *
 *  @return New size.
 */
+ (CGSize)resetFromSize:(CGSize)size withFixedHeight:(CGFloat)height;

@end
