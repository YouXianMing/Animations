//
//  DrawRectObject.m
//  DrawRectObject
//
//  Created by YouXianMing on 16/7/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "DrawRectObject.h"

@interface DrawRectObject ()

@property (nonatomic)         CGContextRef  context;
@property (nonatomic, strong) DrawingStyle *currentDrawingStyle;

@end

@implementation DrawRectObject

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.drawingStyles = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)bindWithCGContext:(CGContextRef)context {

    self.context = context;
}

#pragma mark - Use style.

- (void)useDrawingStyle:(DrawingStyle *)style {
    
    NSParameterAssert(style);
    
    if ([_currentDrawingStyle isEqual:style]) {
        
        return;
        
    } else {
    
        _currentDrawingStyle = style;
    }
    
    // Set RGB Fill Color
    CGContextSetRGBFillColor(_context, style.fillColor.red, style.fillColor.green, style.fillColor.blue, style.fillColor.alpha);
    
    // Set Line Width
    CGContextSetLineWidth(_context, style.lineWidth);
    
    // Set RGB Stroke Color
    CGContextSetRGBStrokeColor(_context, style.strokeColor.red, style.strokeColor.green, style.strokeColor.blue, style.strokeColor.alpha);
    
    // Set Line Cap
    CGContextSetLineCap(_context, style.lineCap);
    
    // Set Line Join
    CGContextSetLineJoin(_context, style.lineJoin);
    
    // Set Line Dash
    CGContextSetLineDash(_context, style.phase, style.lengths, style.count);
}

- (void)useDrawingStyle:(DrawingStyle *)style drawStrokeBlock:(DrawRectObjectDrawBlock_t)block {

    NSParameterAssert(style);
    
    [self useDrawingStyle:style];
    [self beginPath];
    
    if (block) {
        
        __weak DrawRectObject *weakSelf = self;
        block(weakSelf);
    }
    
    [self strokePath];
}

- (void)useDrawingStyle:(DrawingStyle *)style drawFillBlock:(DrawRectObjectDrawBlock_t)block {
    
    NSParameterAssert(style);
    
    [self useDrawingStyle:style];
    [self beginPath];
    
    if (block) {
        
        __weak DrawRectObject *weakSelf = self;
        block(weakSelf);
    }
    
    [self fillPath];
}

#pragma mark - Manage path work.

- (void)beginPath {
    
    CGContextBeginPath(_context);
}

- (void)closePath {
    
    CGContextClosePath(_context);
}

- (void)strokePath {
    
    CGContextStrokePath(_context);
}

- (void)fillPath {
    
    CGContextFillPath(_context);
}

- (void)drawPathWithDrawingMode:(CGPathDrawingMode)drawingMode {
    
    CGContextDrawPath(_context, drawingMode);
}

- (void)addRectPath:(CGRect)rect {
    
    CGContextAddRect(_context, rect);
}

- (void)addEllipseInRectPath:(CGRect)rect {
    
    CGContextAddEllipseInRect(_context, rect);
}

- (void)addArcWithCenterPoint:(CGPoint)point radius:(CGFloat)radius
                   startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle
                    clockwise:(BOOL)clockwise {
    
    CGContextAddArc(_context, point.x, point.y, radius, startAngle, endAngle, clockwise);
}

- (void)moveToStartPoint:(CGPoint)point {
    
    CGContextMoveToPoint(_context, point.x, point.y);
}

- (void)addLineToPoint:(CGPoint)point {
    
    CGContextAddLineToPoint(_context, point.x, point.y);
}

- (void)addLinePoints:(NSArray <NSValue *> *)points {
    
    if (points.count > 1) {
        
        for (int i = 0; i < points.count; i++) {
            
            NSValue  *pointValue = points[i];
            CGPoint   point      = pointValue.CGPointValue;
            
            // first point must be used by method "CGContextMoveToPoint"
            if (i == 0) {
                
                CGContextMoveToPoint(_context, point.x, point.y);
                continue;
            }
            
            CGContextAddLineToPoint(_context, point.x, point.y);
        }
    }
}

- (void)addCurveToPoint:(CGPoint)point firstControlPoint:(CGPoint)firstControlPoint secondControlPoint:(CGPoint)secondControlPoint {
    
    CGContextAddCurveToPoint(_context,
                             firstControlPoint.x, firstControlPoint.y,
                             secondControlPoint.x, secondControlPoint.y,
                             point.x, point.y);
}

- (void)addQuadCurveToPoint:(CGPoint)point controlPoint:(CGPoint)controlPoint {
    
    CGContextAddQuadCurveToPoint(_context,
                                 controlPoint.x, controlPoint.y,
                                 point.x, point.y);
}

- (void)saveGState {
    
    CGContextSaveGState(_context);
}

- (void)restoreGState {
    
    CGContextRestoreGState(_context);
}

- (void)scaleCTMwithX:(CGFloat)x y:(CGFloat)y {

    CGContextScaleCTM(_context, x, y);
}

- (void)translateCTMwithX:(CGFloat)x y:(CGFloat)y {
    
    CGContextTranslateCTM(_context, x, y);
}

- (void)rotateCTMwithAngle:(CGFloat)angle {

    CGContextRotateCTM(_context, angle);
}

- (void)concatCTMwithCGAffineTransform:(CGAffineTransform)transform {

    CGContextConcatCTM(_context, transform);
}

- (CGAffineTransform)drawRectObjectGetCTM {

    return CGContextGetCTM(_context);
}

@end


