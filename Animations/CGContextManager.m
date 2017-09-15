//
//  CGContextManager.m
//  CGContext
//
//  Created by YouXianMing on 2017/8/23.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CGContextManager.h"

@interface CGContextManager ()

@property (nonatomic)       CGContextRef  context;
@property (nonatomic, weak) UIView       *view;

@end

@implementation CGContextManager

+ (instancetype)contextManagerFromView:(UIView *)view {
    
    CGContextManager *manager = [[self class] new];
    manager.view              = view;
    
    // DrawRect模式下,背景色是黑色的,这里将其设置成透明色的
    view.backgroundColor = [UIColor clearColor];
    
    return manager;
}

- (void)startDraw {
    
    self.context = [self.view getCurrentContext];
}

#pragma mark - 'UIView+DrawRect.h' 的壳(外观设计模式)

- (void)useDrawingAttribute:(DrawingAttribute *)drawingAttribute {
    
    [self.view context:self.context useDrawingAttribute:drawingAttribute];
}

- (void)fillRect:(CGRect)rect {
    
    [self.view fillRectPathWithContext:self.context rect:rect];
}

- (void)fillWithRectValueArrayBlock:(NSArray <NSValue *> * (^)(void))rectValueArrayBlock {
    
    [self.view fillRectsPathWithContext:self.context rectValueArrayBlock:rectValueArrayBlock];
}

- (void)strokeLinePathWithPointValueArrayBlock:(NSArray <NSValue *> * (^)(void))pointValueArrayBlock closePath:(BOOL)closePath {
    
    [self.view strokeLinePathWithContext:self.context pointValueArrayBlock:pointValueArrayBlock closePath:closePath];
}

- (void)strokeLinesPathWithPointValuesArraysBlock:(NSArray <NSArray <NSValue *> *> * (^)(void))pointValuesArraysBlock closePath:(BOOL)closePath {
    
    [self.view strokeLinesPathWithContext:self.context pointValuesArraysBlock:pointValuesArraysBlock closePath:closePath];
}

- (void)fillCircleWithRadius:(CGFloat)radius centerPoint:(CGPoint)centerPoint {
    
    [self.view fillCircleWithContext:self.context radius:radius centerPoint:centerPoint];
}

- (void)fillCirclesWithRadius:(CGFloat)radius centerPointValueArrayBlock:(NSArray <NSValue *> * (^)(void))centerPointValueArrayBlock {
    
    [self.view fillCirclesWithContext:self.context radius:radius centerPointValueArrayBlock:centerPointValueArrayBlock];
}

- (void)strokeCircleRadius:(CGFloat)radius centerPoint:(CGPoint)centerPoint {
    
    [self.view strokeCircleWithContext:self.context radius:radius centerPoint:centerPoint];
}

- (void)strokeCirclesRadius:(CGFloat)radius centerPointValueArrayBlock:(NSArray <NSValue *> * (^)(void))centerPointValueArrayBlock {
    
    [self.view strokeCirclesWithContext:self.context radius:radius centerPointValueArrayBlock:centerPointValueArrayBlock];
}

- (void)drawInSpecialState:(void (^)(CGContextRef context))specialStateBlock {
    
    [self.view drawWithContext:self.context inSpecialState:specialStateBlock];
}

- (void)drawAttributeString:(NSAttributedString *)attributedString atPoint:(CGPoint)point offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    
    [self.view drawAttributeString:attributedString atPoint:point offsetX:offsetX offsetY:offsetY];
}

- (void)drawAttributeString:(NSAttributedString *)attributedString
                    atPoint:(CGPoint)point centerAlignment:(EDrawContentCenterAlignmentPosition)centerAlignment
                    offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    
     [self.view drawAttributeString:attributedString atPoint:point centerAlignment:centerAlignment
                offsetX:offsetX offsetY:offsetY];
}

- (void)drawAttributeString:(NSAttributedString *)attributedString inRect:(CGRect)rect {
    
    [self.view drawAttributeString:attributedString inRect:rect];
}

- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    
    [self.view drawImage:image atPoint:point offsetX:offsetX offsetY:offsetY];
}

- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode
            alpha:(CGFloat)alpha offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    
    [self.view drawImage:image atPoint:point blendMode:blendMode alpha:alpha offsetX:offsetX offsetY:offsetY];
}

- (void)drawImage:(UIImage *)image inRect:(CGRect)rect {
    
    [self.view drawImage:image inRect:rect];
}

- (void)drawImage:(UIImage *)image inRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha {
    
    [self.view drawImage:image inRect:rect blendMode:blendMode alpha:alpha];
}

- (void)drawImage:(UIImage *)image asPatternInRect:(CGRect)rect {
    
    [self.view drawImage:image asPatternInRect:rect];
}

- (void)shouldAntialias:(BOOL)shouldAntialias {

    [self.view context:self.context shouldAntialias:shouldAntialias];
}

@end
