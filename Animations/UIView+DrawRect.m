//
//  UIView+DrawRect.m
//  CGContext
//
//  Created by YouXianMing on 2017/8/23.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "UIView+DrawRect.h"

@implementation UIView (DrawRect)

- (CGContextRef)getCurrentContext {
    
    return UIGraphicsGetCurrentContext();
}

- (void)context:(CGContextRef)context useDrawingAttribute:(DrawingAttribute *)drawingAttribute {
    
    if (context && drawingAttribute) {
        
        CGContextSetLineWidth(context, drawingAttribute.lineWidth);
        CGContextSetLineCap(context, drawingAttribute.lineCap);
        CGContextSetLineJoin(context, drawingAttribute.lineJoin);
        
        if (drawingAttribute.fillColor) {
            
            CGContextSetFillColorWithColor(context, drawingAttribute.fillColor.CGColor);
        }
        
        if (drawingAttribute.strokeColor) {
            
            CGContextSetStrokeColorWithColor(context, drawingAttribute.strokeColor.CGColor);
        }
        
        if (drawingAttribute.lineDashLengths.count) {
            
            CGFloat *lengths = CGFloatArrayWithCount(drawingAttribute.lineDashLengths.count);
            
            [drawingAttribute.lineDashLengths enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger idx, BOOL *stop) {
                
                lengths[idx] = value.floatValue;
            }];
            
            free(lengths);
            
            CGContextSetLineDash(context, drawingAttribute.phase, lengths, drawingAttribute.lineDashLengths.count);
            
        } else {
            
            CGContextSetLineDash(context, drawingAttribute.phase, nil, 0);
        }
    }
}

#pragma mark - Stroke & Fill

- (void)fillRectPathWithContext:(CGContextRef)context rect:(CGRect)rect {
    
    // 在context中创建一条空path
    CGContextBeginPath(context);
    
    CGContextAddRect(context, rect);
    
    // 在当前线条上进行填充
    CGContextFillPath(context);
}

- (void)fillRectsPathWithContext:(CGContextRef)context
             rectValueArrayBlock:(NSArray <NSValue *> * (^)(void))rectValueArrayBlock {
    
    // 在context中创建一条空path
    CGContextBeginPath(context);
    
    NSArray <NSValue *> *valuesArray = nil;
    
    if (rectValueArrayBlock) {
        
        valuesArray = rectValueArrayBlock();
    }
    
    [valuesArray enumerateObjectsUsingBlock:^(NSValue *rectValue, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGContextAddRect(context, [rectValue CGRectValue]);
    }];
    
    // 闭合这条path
    CGContextClosePath(context);
    
    // 在当前线条上进行填充
    CGContextFillPath(context);
}

- (void)strokeLinePathWithContext:(CGContextRef)context
             pointValueArrayBlock:(NSArray <NSValue *> * (^)(void))pointValueArrayBlock
                        closePath:(BOOL)closePath {
    
    // 在context中创建一条空path
    CGContextBeginPath(context);
    
    NSArray <NSValue *> *valuesArray = nil;
    
    if (pointValueArrayBlock) {
        
        valuesArray = pointValueArrayBlock();
    }
    
    [valuesArray enumerateObjectsUsingBlock:^(NSValue *pointValue, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGPoint point = [pointValue CGPointValue];
        idx == 0 ? CGContextMoveToPoint(context, point.x, point.y) : CGContextAddLineToPoint(context, point.x, point.y);
    }];
    
    closePath == YES ? CGContextClosePath(context) : 0;
    
    // 在当前线条上进行绘制
    CGContextStrokePath(context);
}

- (void)strokeLinesPathWithContext:(CGContextRef)context
            pointValuesArraysBlock:(NSArray <NSArray <NSValue *> *> * (^)(void))pointValuesArraysBlock
                         closePath:(BOOL)closePath {
    
    // 在context中创建一条空path
    CGContextBeginPath(context);
    
    NSArray <NSArray <NSValue *> *> *valuesArray = nil;
    
    if (pointValuesArraysBlock) {
        
        valuesArray = pointValuesArraysBlock();
    }
    
    [valuesArray enumerateObjectsUsingBlock:^(NSArray<NSValue *> *pointArray, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [pointArray enumerateObjectsUsingBlock:^(NSValue *pointValue, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGPoint point = [pointValue CGPointValue];
            idx == 0 ? CGContextMoveToPoint(context, point.x, point.y) : CGContextAddLineToPoint(context, point.x, point.y);
        }];
    }];
    
    closePath == YES ? CGContextClosePath(context) : 0;
    
    // 在当前线条上进行绘制
    CGContextStrokePath(context);
}

- (void)fillCircleWithContext:(CGContextRef)context radius:(CGFloat)radius centerPoint:(CGPoint)centerPoint {
    
    // 在context中创建一条空path
    CGContextBeginPath(context);
    
    CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, 0, M_PI * 2, 0);
    
    // 在当前path上进行填充
    CGContextFillPath(context);
}

- (void)fillCirclesWithContext:(CGContextRef)context
                        radius:(CGFloat)radius
    centerPointValueArrayBlock:(NSArray <NSValue *> * (^)(void))centerPointValueArrayBlock {
    
    NSArray <NSValue *> *valuesArray = nil;
    
    if (centerPointValueArrayBlock) {
        
        valuesArray = centerPointValueArrayBlock();
    }
    
    [valuesArray enumerateObjectsUsingBlock:^(NSValue *centerPointValue, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 在context中创建一条空path
        CGContextBeginPath(context);
        
        CGPoint point = [centerPointValue CGPointValue];
        CGContextAddArc(context, point.x, point.y, radius, 0, M_PI * 2, 0);
        
        // 在当前path上进行填充
        CGContextFillPath(context);
    }];
}

- (void)strokeCirclesWithContext:(CGContextRef)context
                          radius:(CGFloat)radius
      centerPointValueArrayBlock:(NSArray <NSValue *> * (^)(void))centerPointValueArrayBlock {
    
    NSArray <NSValue *> *valuesArray = nil;
    
    if (centerPointValueArrayBlock) {
        
        valuesArray = centerPointValueArrayBlock();
    }
    
    [valuesArray enumerateObjectsUsingBlock:^(NSValue *centerPointValue, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 在context中创建一条空path
        CGContextBeginPath(context);
        
        CGPoint point = [centerPointValue CGPointValue];
        CGContextAddArc(context, point.x, point.y, radius, 0, M_PI * 2, 0);
        
        // 在当前path上进行描边
        CGContextStrokePath(context);
    }];
}

- (void)strokeCircleWithContext:(CGContextRef)context radius:(CGFloat)radius centerPoint:(CGPoint)centerPoint {
    
    // 在context中创建一条空path
    CGContextBeginPath(context);
    
    CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, 0, M_PI * 2, 0);
    
    // 在当前path上进行填充
    CGContextStrokePath(context);
}

- (void)drawWithContext:(CGContextRef)context inSpecialState:(void (^)(CGContextRef context))specialStateBlock {
    
    CGContextSaveGState(context);
    
    if (specialStateBlock) {
        
        specialStateBlock(context);
    }
    
    CGContextRestoreGState(context);
}

#pragma mark - String

- (void)drawAttributeString:(NSAttributedString *)attributedString atPoint:(CGPoint)point offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    
    [attributedString drawAtPoint:CGPointMake(point.x + offsetX, point.y + offsetY)];
}

- (void)drawAttributeString:(NSAttributedString *)attributedString
        atPoint:(CGPoint)point centerAlignment:(EDrawContentCenterAlignmentPosition)centerAlignment
        offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {

    CGSize size = attributedString.size;
        
    if (centerAlignment == DrawContentCenterAlignmentLeftSide) {
        
        [attributedString drawAtPoint:CGPointMake(point.x - size.width + offsetX, point.y - size.height / 2.f + offsetY)];
        
    } else if (centerAlignment == DrawContentCenterAlignmentRightSide) {
        
        [attributedString drawAtPoint:CGPointMake(point.x + offsetX, point.y - size.height / 2.f + offsetY)];
        
    } else if (centerAlignment == DrawContentCenterAlignmentTopSide) {
        
        [attributedString drawAtPoint:CGPointMake(point.x - size.width / 2.f + offsetX, point.y - size.height + offsetY)];
        
    } else if (centerAlignment == DrawContentCenterAlignmentBottomSide) {
        
        [attributedString drawAtPoint:CGPointMake(point.x - size.width / 2.f + offsetX, point.y + offsetY)];
        
    } else {
        
        [attributedString drawAtPoint:CGPointMake(point.x - size.width / 2.f + offsetX, point.y - size.height / 2.f + offsetY)];
    }
}

- (void)drawAttributeString:(NSAttributedString *)attributedString inRect:(CGRect)rect {
    
    [attributedString drawInRect:rect];
}

#pragma mark - Image

- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    
    [image drawAtPoint:CGPointMake(point.x + offsetX, point.y + offsetY)];
}

- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode
            alpha:(CGFloat)alpha offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    
    [image drawAtPoint:CGPointMake(point.x + offsetX, point.y + offsetY) blendMode:blendMode alpha:alpha];
}

- (void)drawImage:(UIImage *)image inRect:(CGRect)rect {
    
    [image drawInRect:rect];
}

- (void)drawImage:(UIImage *)image inRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha {
    
    [image drawInRect:rect blendMode:blendMode alpha:alpha];
}

- (void)drawImage:(UIImage *)image asPatternInRect:(CGRect)rect {
    
    [image drawAsPatternInRect:rect];
}

#pragma mark - Set

- (void)context:(CGContextRef)context shouldAntialias:(BOOL)shouldAntialias {
    
    CGContextSetShouldAntialias(context, shouldAntialias);
}

@end
