//
//  CGContextObject.m
//  CGContextObject
//
//  Created by YouXianMing on 15/11/12.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "CGContextObject.h"

@interface CGContextObject ()

@property (nonatomic)         CGContextRef           context;
@property (nonatomic, strong) CGContextObjectConfig *currentConfig;
@property (nonatomic, strong) NSMutableDictionary    <NSString *, CGContextObjectConfig *> *configs;

@end

@implementation CGContextObject

- (instancetype)initWithCGContext:(CGContextRef)context config:(CGContextObjectConfig *)config {
    
    if (self = [super init]) {
        
        self.context       = context;
        self.currentConfig = config;
        
        self.configs       = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)useCGContextConfig:(CGContextObjectConfig *)contextConfig storeAsCurrentConfig:(BOOL)asCurrentConfig {
    
    NSParameterAssert(contextConfig);
    
    // Set RGB Fill Color
    CGContextSetRGBFillColor(_context,
                             contextConfig.fillColor.red,
                             contextConfig.fillColor.green,
                             contextConfig.fillColor.blue,
                             contextConfig.fillColor.alpha);
    
    // Set Line Width
    CGContextSetLineWidth(_context,
                          contextConfig.lineWidth);
    
    // Set RGB Stroke Color
    CGContextSetRGBStrokeColor(_context,
                               contextConfig.strokeColor.red,
                               contextConfig.strokeColor.green,
                               contextConfig.strokeColor.blue,
                               contextConfig.strokeColor.alpha);
    
    // Set Line Cap
    CGContextSetLineCap(_context,
                        contextConfig.lineCap);
    
    // Set Line Join
    CGContextSetLineJoin(_context,
                         contextConfig.lineJoin);
    
    // Set Line Dash
    CGContextSetLineDash(_context,
                         contextConfig.phase,
                         contextConfig.lengths,
                         contextConfig.count);
    
    if (asCurrentConfig == YES) {
        
        self.currentConfig = contextConfig;
    }
}

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
    
    CGContextAddArc(_context, point.x, point.y,
                    radius,
                    startAngle, endAngle,
                    clockwise);
}

- (void)contextConfig:(CGContextObjectConfig *)config drawStrokeBlock:(CGContextObjectDrawBlock_t)block {
    
    if (config) {
        
        [self useCGContextConfig:config storeAsCurrentConfig:NO];
        
    } else {
        
        [self useCGContextConfig:self.currentConfig storeAsCurrentConfig:NO];
    }
    
    [self beginPath];
    
    if (block) {
        
        __weak CGContextObject *weakSelf = self;
        
        block(weakSelf);
    }
    
    [self strokePath];
}

- (void)contextConfig:(CGContextObjectConfig *)config drawFillBlock:(CGContextObjectDrawBlock_t)block {
    
    if (config) {
        
        [self useCGContextConfig:config storeAsCurrentConfig:NO];
        
    } else {
        
        [self useCGContextConfig:self.currentConfig storeAsCurrentConfig:NO];
    }
    
    [self beginPath];
    
    if (block) {
        
        __weak CGContextObject *weakSelf = self;
        
        block(weakSelf);
    }
    
    [self fillPath];
}

- (void)contextConfig:(CGContextObjectConfig *)config drawingMode:(CGPathDrawingMode)drawingMode drawBlock:(CGContextObjectDrawBlock_t)block {
    
    if (config) {
        
        [self useCGContextConfig:config storeAsCurrentConfig:NO];
        
    } else {
        
        [self useCGContextConfig:self.currentConfig storeAsCurrentConfig:NO];
    }
    
    [self beginPath];
    
    if (block) {
        
        __weak CGContextObject *weakSelf = self;
        
        block(weakSelf);
    }
    
    [self drawPathWithDrawingMode:drawingMode];
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


- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point {
    
    [image drawAtPoint:point];
}

- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha {
    
    [image drawAtPoint:point blendMode:blendMode alpha:alpha];
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

- (void)saveGState {
    
    CGContextSaveGState(_context);
}

- (void)restoreGState {
    
    CGContextRestoreGState(_context);
}

- (void)drawInCurrentSpecialState:(CGContextObjectDrawBlock_t)block {
    
    if (block) {
        
        [self saveGState];
        
        __weak CGContextObject *weakSelf = self;
        
        block(weakSelf);
        
        [self restoreGState];
    }
}

- (void)drawString:(NSString *)string atPoint:(CGPoint)point withAttributes:(NSDictionary *)attributes {
    
    [string drawAtPoint:point withAttributes:attributes];
}

- (void)drawString:(NSString *)string inRect:(CGRect)rect withAttributes:(NSDictionary *)attributes {
    
    [string drawInRect:rect withAttributes:attributes];
}

- (void)drawAttributedString:(NSAttributedString *)string atPoint:(CGPoint)point {
    
    [string drawAtPoint:point];
}

- (void)drawAttributedString:(NSAttributedString *)string inRect:(CGRect)rect {
    
    [string drawInRect:rect];
}

- (void)drawLinearGradientAtClipToRect:(CGRect)rect
                         gradientColor:(GradientColor *)gradientColor
                            startPoint:(CGPoint)startPoint
                              endPoint:(CGPoint)endPoint {
    
    NSParameterAssert(gradientColor);
    
    [self saveGState];
    
    CGContextClipToRect(_context, rect);
    
    CGContextDrawLinearGradient(_context,
                                gradientColor.gradientRef,
                                startPoint,
                                endPoint, kCGGradientDrawsBeforeStartLocation);
    
    [self restoreGState];
}

@end
