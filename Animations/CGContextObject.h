//
//  CGContextObject.h
//  CGContextObject
//
//  Created by YouXianMing on 15/11/12.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "CGContextObjectConfig.h"
#import "GradientColor.h"
@class CGContextObject;


typedef void(^CGContextObjectDrawBlock_t)(CGContextObject *contextObject);


@interface CGContextObject : NSObject

/**
 *  An opaque type that represents a Quartz 2D drawing environment.
 */
@property (nonatomic, readonly) CGContextRef context;

/**
 *  Current context config.
 */
@property (nonatomic, strong, readonly) CGContextObjectConfig *currentConfig;

/**
 *  Context config array.
 */
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, CGContextObjectConfig *> *configs;

/**
 *  Init method.
 *
 *  @param context An opaque type that represents a Quartz 2D drawing environment.
 *  @param config  Context config
 *
 *  @return Context config object
 */
- (instancetype)initWithCGContext:(CGContextRef)context config:(CGContextObjectConfig *)config;

/**
 *  Use the context config & store as current config.
 *
 *  @param contextConfig   Context config object.
 *  @param asCurrentConfig Yes means store, No means not store.
 */
- (void)useCGContextConfig:(CGContextObjectConfig *)contextConfig storeAsCurrentConfig:(BOOL)asCurrentConfig;

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
- (void)addArcWithCenterPoint:(CGPoint)point radius:(CGFloat)radius
                   startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle
                    clockwise:(BOOL)clockwise;

#pragma mark - Draw construction method.

/**
 *  beginPath + your draw code + strokePath
 *
 *  @param config context config
 *  @param block  draw block
 */
- (void)contextConfig:(CGContextObjectConfig *)config drawStrokeBlock:(CGContextObjectDrawBlock_t)block;

/**
 *  beginPath + your draw code + fillPath
 *
 *  @param config context config
 *  @param block  draw block
 */
- (void)contextConfig:(CGContextObjectConfig *)config drawFillBlock:(CGContextObjectDrawBlock_t)block;

/**
 *  beginPath + your draw code + drawPathWithDrawingMode
 *
 *  @param config      context config
 *  @param drawingMode A path drawing mode constant—kCGPathFill, kCGPathEOFill, kCGPathStroke, kCGPathFillStroke, or kCGPathEOFillStroke. For a discussion of these constants, see CGPath Reference.
 *  @param block       draw block
 */
- (void)contextConfig:(CGContextObjectConfig *)config drawingMode:(CGPathDrawingMode)drawingMode drawBlock:(CGContextObjectDrawBlock_t)block;

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

#pragma mark - Image related.

/**
 *  Draws the image at the specified point in the current context.
 *
 *  @param image the image
 *  @param point The point at which to draw the top-left corner of the image.
 */
- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point;

/**
 *  Draws the entire image at the specified point using the custom compositing options.
 *
 *  @param image     The image
 *  @param point     The point at which to draw the top-left corner of the image.
 *  @param blendMode The blend mode to use when compositing the image.
 *  @param alpha     The desired opacity of the image, specified as a value between 0.0 and 1.0. A value of 0.0 renders the image totally transparent while 1.0 renders it fully opaque. Values larger than 1.0 are interpreted as 1.0.
 */
- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

/**
 *  Draws the entire image in the specified rectangle, scaling it as needed to fit.
 *
 *  @param image The image
 *  @param rect  The rectangle (in the coordinate system of the graphics context) in which to draw the image.
 */
- (void)drawImage:(UIImage *)image inRect:(CGRect)rect;

/**
 *  Draws the entire image in the specified rectangle and using the specified compositing options.
 *
 *  @param image     The image
 *  @param rect      The rectangle (in the coordinate system of the graphics context) in which to draw the image.
 *  @param blendMode The blend mode to use when compositing the image.
 *  @param alpha     The desired opacity of the image, specified as a value between 0.0 and 1.0. A value of 0.0 renders the image totally transparent while 1.0 renders it fully opaque. Values larger than 1.0 are interpreted as 1.0.
 */
- (void)drawImage:(UIImage *)image inRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

/**
 *  Draws a tiled Quartz pattern using the receiver’s contents as the tile pattern.
 *
 *  @param image The image
 *  @param rect  The rectangle (in the coordinate system of the graphics context) in which to draw the image.
 */
- (void)drawImage:(UIImage *)image asPatternInRect:(CGRect)rect;

#pragma mark - State related.

/**
 *  Pushes a copy of the current graphics state onto the graphics state stack for the context.
 */
- (void)saveGState;

/**
 *  Sets the current graphics state to the state most recently saved.
 */
- (void)restoreGState;

/**
 *  saveGState + restoreGState
 *
 *  @param block draw block
 */
- (void)drawInCurrentSpecialState:(CGContextObjectDrawBlock_t)block;

#pragma mark - String related.

/**
 *  Draws the receiver with the font and other display characteristics of the given attributes, at the specified point in the current graphics context.
 *
 *  @param string     The string
 *  @param point      The point in the current graphics context where you want to start drawing the string. The coordinate system of the graphics context is usually defined by the view in which you are drawing.
 *  @param attributes A dictionary of text attributes to be applied to the string. These are the same attributes that can be applied to an NSAttributedString object, but in the case of NSString objects, the attributes apply to the entire string, rather than ranges within the string.
 */
- (void)drawString:(NSString *)string atPoint:(CGPoint)point withAttributes:(NSDictionary *)attributes;

/**
 *  Draws the attributed string inside the specified bounding rectangle in the current graphics context.
 *
 *  @param string     The string
 *  @param rect       The bounding rectangle in which to draw the string.
 *  @param attributes A dictionary of text attributes to be applied to the string. These are the same attributes that can be applied to an NSAttributedString object, but in the case of NSString objects, the attributes apply to the entire string, rather than ranges within the string.
 */
- (void)drawString:(NSString *)string inRect:(CGRect)rect withAttributes:(NSDictionary *)attributes;

/**
 *  Draws the attributed string starting at the specified point in the current graphics context.
 *
 *  @param string The attributedString
 *  @param point  The point in the current graphics context where you want to start drawing the string. The coordinate system of the graphics context is usually defined by the view in which you are drawing.
 */
- (void)drawAttributedString:(NSAttributedString *)string atPoint:(CGPoint)point;

/**
 *  Draws the attributed string inside the specified bounding rectangle in the current graphics context.
 *
 *  @param string The attributedString
 *  @param rect   The bounding rectangle in which to draw the string.
 */
- (void)drawAttributedString:(NSAttributedString *)string inRect:(CGRect)rect;

#pragma mark - Draw gradient color.

/**
 *  Paints a gradient fill that varies along the line defined by the provided starting and ending points.
 *
 *  @param rect          Sets the clipping path to the intersection of the current clipping path with the area defined by the specified rectangle.
 *  @param gradientColor GradientColor object
 *  @param startPoint    The coordinate that defines the starting point of the gradient.
 *  @param endPoint      The coordinate that defines the ending point of the gradient.
 */
- (void)drawLinearGradientAtClipToRect:(CGRect)rect
                         gradientColor:(GradientColor *)gradientColor
                            startPoint:(CGPoint)startPoint
                              endPoint:(CGPoint)endPoint;

@end
