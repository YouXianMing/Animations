//
//  CGContextManager.h
//  CGContext
//
//  Created by YouXianMing on 2017/8/23.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+DrawRect.h"

@interface CGContextManager : NSObject

@property (nonatomic, readonly) CGContextRef context;

+ (instancetype)contextManagerFromView:(UIView *)view;

- (void)startDraw;

#pragma mark - 'UIView+DrawRect.h' 的壳(外观设计模式)

- (void)useDrawingAttribute:(DrawingAttribute *)drawingAttribute;

- (void)fillRect:(CGRect)rect;

- (void)fillWithRectValueArrayBlock:(NSArray <NSValue *> * (^)(void))rectValueArrayBlock;

- (void)strokeLinePathWithPointValueArrayBlock:(NSArray <NSValue *> * (^)(void))pointValueArrayBlock closePath:(BOOL)closePath;

- (void)strokeLinesPathWithPointValuesArraysBlock:(NSArray <NSArray <NSValue *> *> * (^)(void))pointValuesArraysBlock closePath:(BOOL)closePath;

- (void)fillCircleWithRadius:(CGFloat)radius centerPoint:(CGPoint)centerPoint;

- (void)fillCirclesWithRadius:(CGFloat)radius centerPointValueArrayBlock:(NSArray <NSValue *> * (^)(void))centerPointValueArrayBlock;

- (void)strokeCircleRadius:(CGFloat)radius centerPoint:(CGPoint)centerPoint;

- (void)strokeCirclesRadius:(CGFloat)radius centerPointValueArrayBlock:(NSArray <NSValue *> * (^)(void))centerPointValueArrayBlock;

- (void)drawInSpecialState:(void (^)(CGContextRef context))specialStateBlock;

- (void)drawAttributeString:(NSAttributedString *)attributedString atPoint:(CGPoint)point offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;

- (void)drawAttributeString:(NSAttributedString *)attributedString
                    atPoint:(CGPoint)point centerAlignment:(EDrawContentCenterAlignmentPosition)centerAlignment
                    offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;

- (void)drawAttributeString:(NSAttributedString *)attributedString inRect:(CGRect)rect;

- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;

- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode
            alpha:(CGFloat)alpha offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;

- (void)drawImage:(UIImage *)image inRect:(CGRect)rect;

- (void)drawImage:(UIImage *)image inRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

- (void)drawImage:(UIImage *)image asPatternInRect:(CGRect)rect;

- (void)shouldAntialias:(BOOL)shouldAntialias;

@end
