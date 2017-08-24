//
//  UIBezierPath+Interpolation.m
//  Curve Interpolation
//
//  Created by John Fisher on 4/26/14.
//  Copyright (c) 2014 John Fisher. All rights reserved.
//

#import "UIBezierPath+Interpolation.h"
#import "CGPointExtension.h"

#define kEPSILON 1.0e-5

@implementation UIBezierPath (Interpolation)

+(UIBezierPath *)interpolateCGPointsWithCatmullRom:(NSArray *)pointsAsNSValues closed:(BOOL)closed alpha:(float)alpha {
    if ([pointsAsNSValues count] < 4)
        return nil;
    
    NSInteger endIndex = (closed ? [pointsAsNSValues count] : [pointsAsNSValues count]-2);
    NSAssert(alpha >= 0.0 && alpha <= 1.0, @"alpha value is between 0.0 and 1.0, inclusive");
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSInteger startIndex = (closed ? 0 : 1);
    for (NSInteger ii=startIndex; ii < endIndex; ++ii) {
        CGPoint p0, p1, p2, p3;
        NSInteger nextii      = (ii+1)%[pointsAsNSValues count];
        NSInteger nextnextii  = (nextii+1)%[pointsAsNSValues count];
        NSInteger previi      = (ii-1 < 0 ? [pointsAsNSValues count]-1 : ii-1);
        
        [pointsAsNSValues[ii] getValue:&p1];
        [pointsAsNSValues[previi] getValue:&p0];
        [pointsAsNSValues[nextii] getValue:&p2];
        [pointsAsNSValues[nextnextii] getValue:&p3];
        
        CGFloat d1 = ccpLength(ccpSub(p1, p0));
        CGFloat d2 = ccpLength(ccpSub(p2, p1));
        CGFloat d3 = ccpLength(ccpSub(p3, p2));
        
        CGPoint b1, b2;
        if (fabs(d1) < kEPSILON) {
            b1 = p1;
        }
        else {
            b1 = ccpMult(p2, powf(d1, 2*alpha));
            b1 = ccpSub(b1, ccpMult(p0, powf(d2, 2*alpha)));
            b1 = ccpAdd(b1, ccpMult(p1,(2*powf(d1, 2*alpha) + 3*powf(d1, alpha)*powf(d2, alpha) + powf(d2, 2*alpha))));
            b1 = ccpMult(b1, 1.0 / (3*powf(d1, alpha)*(powf(d1, alpha)+powf(d2, alpha))));
        }
        
        if (fabs(d3) < kEPSILON) {
            b2 = p2;
        }
        else {
            b2 = ccpMult(p1, powf(d3, 2*alpha));
            b2 = ccpSub(b2, ccpMult(p3, powf(d2, 2*alpha)));
            b2 = ccpAdd(b2, ccpMult(p2,(2*powf(d3, 2*alpha) + 3*powf(d3, alpha)*powf(d2, alpha) + powf(d2, 2*alpha))));
            b2 = ccpMult(b2, 1.0 / (3*powf(d3, alpha)*(powf(d3, alpha)+powf(d2, alpha))));
        }
        
        if (ii==startIndex)
            [path moveToPoint:p1];
        
        [path addCurveToPoint:p2 controlPoint1:b1 controlPoint2:b2];
    }
    
    if (closed)
        [path closePath];
    
    return path;
}

+(UIBezierPath *)interpolateCGPointsWithHermite:(NSArray *)pointsAsNSValues closed:(BOOL)closed {
    if ([pointsAsNSValues count] < 2)
        return nil;
    
    NSInteger nCurves = (closed ? [pointsAsNSValues count] : [pointsAsNSValues count]-1);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger ii=0; ii < nCurves; ++ii) {
        NSValue *value  = pointsAsNSValues[ii];
        
        CGPoint curPt, prevPt, nextPt, endPt;
        [value getValue:&curPt];
        if (ii==0)
            [path moveToPoint:curPt];
        
        NSInteger nextii = (ii+1)%[pointsAsNSValues count];
        NSInteger previi = (ii-1 < 0 ? [pointsAsNSValues count]-1 : ii-1);
        
        [pointsAsNSValues[previi] getValue:&prevPt];
        [pointsAsNSValues[nextii] getValue:&nextPt];
        endPt = nextPt;
        
        CGFloat mx, my;
        if (closed || ii > 0) {
            mx = (nextPt.x - curPt.x)*0.5 + (curPt.x - prevPt.x)*0.5;
            my = (nextPt.y - curPt.y)*0.5 + (curPt.y - prevPt.y)*0.5;
        }
        else {
            mx = (nextPt.x - curPt.x)*0.5;
            my = (nextPt.y - curPt.y)*0.5;
        }
        
        CGPoint ctrlPt1;
        ctrlPt1.x = curPt.x + mx / 3.0;
        ctrlPt1.y = curPt.y + my / 3.0;
        
        [pointsAsNSValues[nextii] getValue:&curPt];
        
        nextii = (nextii+1)%[pointsAsNSValues count];
        previi = ii;
        
        [pointsAsNSValues[previi] getValue:&prevPt];
        [pointsAsNSValues[nextii] getValue:&nextPt];
        
        if (closed || ii < nCurves-1) {
            mx = (nextPt.x - curPt.x)*0.5 + (curPt.x - prevPt.x)*0.5;
            my = (nextPt.y - curPt.y)*0.5 + (curPt.y - prevPt.y)*0.5;
        }
        else {
            mx = (curPt.x - prevPt.x)*0.5;
            my = (curPt.y - prevPt.y)*0.5;
        }
        
        CGPoint ctrlPt2;
        ctrlPt2.x = curPt.x - mx / 3.0;
        ctrlPt2.y = curPt.y - my / 3.0;
        
        [path addCurveToPoint:endPt controlPoint1:ctrlPt1 controlPoint2:ctrlPt2];
    }
    
    if (closed)
        [path closePath];
    
    return path;
}


@end
