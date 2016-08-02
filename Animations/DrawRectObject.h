//
//  DrawRectObject.h
//  DrawRectObject
//
//  Created by YouXianMing on 16/7/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "DrawingStyle.h"
@class DrawRectObject;

typedef void(^DrawRectObjectDrawBlock_t)(DrawRectObject *drawRectObject);

@interface DrawRectObject : NSObject

/**
 *  An opaque type that represents a Quartz 2D drawing environment.
 */
@property (nonatomic, readonly) CGContextRef context;

/**
 *  The drawing styles dictionary, you can use this to store the drawing style.
 */
@property (nonatomic, strong) NSMutableDictionary  <NSString *, DrawingStyle *> *drawingStyles;

/**
 *  Bind with the
 *
 *  @param context CGContextRef object.
 */
- (void)bindWithCGContext:(CGContextRef)context;

#pragma mark - Manage path work.

/**
 *  Creates a new empty path in a graphics context.
 */
- (void)beginPath;

/**
 *  Closes and terminates the current path’s subpath.
 */
- (void)closePath;

/**
 *  Paints a line along the current path.
 */
- (void)strokePath;

/**
 *  Paints the area within the current path, using the nonzero winding number rule.
 */
- (void)fillPath;

/**
 *  Draws the current path using the provided drawing mode.
 *
 *  @param drawingMode A path drawing mode constant—kCGPathFill, kCGPathEOFill, kCGPathStroke, kCGPathFillStroke, or kCGPathEOFillStroke. For a discussion of these constants, see CGPath Reference.
 */
- (void)drawPathWithDrawingMode:(CGPathDrawingMode)drawingMode;

#pragma mark - Path construction convenience functions.

/**
 *  Adds a rectangular path to the current path.
 *
 *  @param rect A rectangle, specified in user space coordinates.
 */
- (void)addRectPath:(CGRect)rect;

/**
 *  Adds an ellipse that fits inside the specified rectangle.
 *
 *  @param rect A rectangle that defines the area for the ellipse to fit in.
 */
- (void)addEllipseInRectPath:(CGRect)rect;

/**
 *  Adds an arc of a circle to the current path, possibly preceded by a straight line segment.
 *
 *  @param point      the center of the arc
 *  @param radius     The radius of the arc, in user space coordinates.
 *  @param startAngle The angle to the starting point of the arc, measured in radians from the positive x-axis.
 *  @param endAngle   The angle to the end point of the arc, measured in radians from the positive x-axis.
 *  @param clockwise  Specify YES to create a clockwise arc or NO to create a counterclockwise arc.
 */
- (void)addArcWithCenterPoint:(CGPoint)point radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;

#pragma mark - Drawing method.

/**
 *  Use the specified style to stroke path.
 *
 *  @param style The drawing style object, you must give this value.
 *  @param block Draw block.
 */
- (void)useDrawingStyle:(DrawingStyle *)style drawStrokeBlock:(DrawRectObjectDrawBlock_t)block;

/**
 *  Use the specified style to fill path.
 *
 *  @param style The drawing style object, you must give this value.
 *  @param block Draw block.
 */
- (void)useDrawingStyle:(DrawingStyle *)style drawFillBlock:(DrawRectObjectDrawBlock_t)block;

#pragma mark - Add point.

/**
 *  Begins a new subpath at the point you specify.
 *
 *  @param point start point
 */
- (void)moveToStartPoint:(CGPoint)point;

/**
 *  Appends a straight line segment from the current point to the provided point .
 *
 *  @param point end point
 */
- (void)addLineToPoint:(CGPoint)point;

/**
 *  Start point and points, it's a combine by moveToStartPoint: & addLineToPoint:
 *
 *  @param points array with point's value.
 */
- (void)addLinePoints:(NSArray <NSValue *> *)points;

/**
 *  Appends a cubic Bézier curve from the current point, using the provided control points and end point .
 *
 *  @param point              end point
 *  @param firstControlPoint  first control point
 *  @param secondControlPoint second control point
 */
- (void)addCurveToPoint:(CGPoint)point firstControlPoint:(CGPoint)firstControlPoint secondControlPoint:(CGPoint)secondControlPoint;

/**
 *  Appends a quadratic Bézier curve from the current point, using a control point and an end point you specify.
 *
 *  @param point        end point
 *  @param controlPoint control point
 */
- (void)addQuadCurveToPoint:(CGPoint)point controlPoint:(CGPoint)controlPoint;

#pragma mark - State related.

/**
 *  Pushes a copy of the current graphics state onto the graphics state stack for the context.
 */
- (void)saveGState;

/**
 *  Sets the current graphics state to the state most recently saved.
 */
- (void)restoreGState;

#pragma mark - CMT related.

/**
 *  Changes the scale of the user coordinate system in a context.
 *
 *  @param x The factor by which to scale the x-axis of the coordinate space of the specified context.
 *  @param y The factor by which to scale the y-axis of the coordinate space of the specified context.
 */
- (void)scaleCTMwithX:(CGFloat)x y:(CGFloat)y;

/**
 *  Changes the origin of the user coordinate system in a context.
 *
 *  @param x The factor by which to scale the x-axis of the coordinate space of the specified context.
 *  @param y The factor by which to scale the y-axis of the coordinate space of the specified context.
 */
- (void)translateCTMwithX:(CGFloat)x y:(CGFloat)y;

/**
 *  Rotates the user coordinate system in a context.
 *
 *  @param angle The angle, in radians, by which to rotate the coordinate space of the specified context. Positive values rotate counterclockwise and negative values rotate clockwise.)
 */
- (void)rotateCTMwithAngle:(CGFloat)angle;

/**
 *  Transforms the user coordinate system in a context using a specified matrix.
 *
 *  @param transform The transformation matrix to apply to the specified context’s current transformation matrix.
 */
- (void)concatCTMwithCGAffineTransform:(CGAffineTransform)transform;

/**
 *  Returns the current transformation matrix.
 *
 *  @return The transformation matrix for the current graphics state of the specified context.
 */
- (CGAffineTransform)drawRectObjectGetCTM;

@end


