//
//  UIView+DrawRect.h
//  CGContext
//
//  Created by YouXianMing on 2017/8/23.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingAttribute.h"

typedef enum : NSUInteger {
    
    // 文本对齐于指定点的左边
    DrawContentCenterAlignmentLeftSide = 1000,
    
    // 文本对齐于指定点的右边
    DrawContentCenterAlignmentRightSide,
    
    // 文本对齐于指定点的上边
    DrawContentCenterAlignmentTopSide,
    
    // 文本对齐于指定点的下边
    DrawContentCenterAlignmentBottomSide,
    
    // 文本对齐于指定点的中间
    DrawContentCenterAlignmentCenterPosition,
    
} EDrawContentCenterAlignmentPosition;

NS_INLINE NSValue *CGPointValue(CGFloat x, CGFloat y) {
    
    return [NSValue valueWithCGPoint:CGPointMake(x, y)];
}

NS_INLINE NSValue *CGRectValue(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    
    return [NSValue valueWithCGRect:CGRectMake(x, y, width, height)];
}

NS_INLINE CGFloat * CGFloatArrayWithCount(NSUInteger count) {
    
    return (CGFloat *)malloc(count * sizeof(CGFloat));
}

@interface UIView (DrawRect)

/**
 获取当前的context
 
 @return context上下文
 */
- (CGContextRef)getCurrentContext;

/**
 对context进行属性设置
 
 @param context context上下文
 @param drawingAttribute 属性
 */
- (void)context:(CGContextRef)context useDrawingAttribute:(DrawingAttribute *)drawingAttribute;

#pragma mark - Stroke & Fill

/**
 在一个path上填充一个矩形区域
 
 @param context context上下文
 @param rect CGRect值
 */
- (void)fillRectPathWithContext:(CGContextRef)context rect:(CGRect)rect;

/**
 在一个path上填充多个矩形区域(注意:不管填充多少个矩形区域,都只是一个path)
 
 @param context context上下文
 @param rectValueArrayBlock 提供CGRect参数的一维数组的block
 */
- (void)fillRectsPathWithContext:(CGContextRef)context
             rectValueArrayBlock:(NSArray <NSValue *> * (^)(void))rectValueArrayBlock;

/**
 在一个path上描绘一条线条
 
 @param context context上下文
 @param pointValueArrayBlock 提供线条参数一维数组的block
 @param closePath 是否闭合线条
 */
- (void)strokeLinePathWithContext:(CGContextRef)context
             pointValueArrayBlock:(NSArray <NSValue *> * (^)(void))pointValueArrayBlock
                        closePath:(BOOL)closePath;

/**
 在一个path上描绘多条线条(注意:不管绘制多少条线条,都只是一个path)
 
 @param context context上下文
 @param pointValuesArraysBlock 提供线条参数二维数组的block
 @param closePath 是否闭合线条
 */
- (void)strokeLinesPathWithContext:(CGContextRef)context
            pointValuesArraysBlock:(NSArray <NSArray <NSValue *> *> * (^)(void))pointValuesArraysBlock
                         closePath:(BOOL)closePath;

/**
 根据给定的圆心在一个path上进行圆形区域的填充
 
 @param context context上下文
 @param radius 圆的半径
 @param centerPoint 圆心点
 */
- (void)fillCircleWithContext:(CGContextRef)context radius:(CGFloat)radius centerPoint:(CGPoint)centerPoint;

/**
 根据给定的圆心点组成的数组,在多个path上进行圆形区域的填充
 
 @param context context上下文
 @param radius 圆的半径
 @param centerPointValueArrayBlock 提供圆心点组成数组的block
 */
- (void)fillCirclesWithContext:(CGContextRef)context
                        radius:(CGFloat)radius
    centerPointValueArrayBlock:(NSArray <NSValue *> * (^)(void))centerPointValueArrayBlock;

/**
 根据给定的圆心点,在一个path上进行圆的描绘
 
 @param context context上下文
 @param radius 圆的半径
 @param centerPoint 圆心点
 */
- (void)strokeCircleWithContext:(CGContextRef)context radius:(CGFloat)radius centerPoint:(CGPoint)centerPoint;

/**
 根据给定的圆心点的数组,在多个path上进行圆的描绘
 
 @param context context上下文
 @param radius 圆的半径
 @param centerPointValueArrayBlock 提供圆心数组的block
 */
- (void)strokeCirclesWithContext:(CGContextRef)context
                          radius:(CGFloat)radius
      centerPointValueArrayBlock:(NSArray <NSValue *> * (^)(void))centerPointValueArrayBlock;

/**
 在一个特殊的设置下绘制,绘制结束后,恢复到之前的设置
 
 @param context context上下文
 @param specialStateBlock 特殊绘制上下文的block
 */
- (void)drawWithContext:(CGContextRef)context inSpecialState:(void (^)(CGContextRef context))specialStateBlock;

#pragma mark - String

/**
 将富文本绘制到指定的点上
 
 @param attributedString 富文本
 @param point 绘制的点
 @param offsetX 偏移量x
 @param offsetY 偏移量y
 */
- (void)drawAttributeString:(NSAttributedString *)attributedString
                    atPoint:(CGPoint)point offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;

/**
 将富文本绘制到指定的点上,并相对指定的点,进行偏移
 
 @param attributedString 富文本
 @param point 绘制的点
 @param centerAlignment 偏移方向
 @param offsetX 偏移量x
 @param offsetY 偏移量y
 */
- (void)drawAttributeString:(NSAttributedString *)attributedString
                    atPoint:(CGPoint)point centerAlignment:(EDrawContentCenterAlignmentPosition)centerAlignment
                    offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;

/**
 将富文本绘制到指定的区域
 
 @param attributedString 富文本
 @param rect 绘制区域
 */
- (void)drawAttributeString:(NSAttributedString *)attributedString inRect:(CGRect)rect;

#pragma mark - Image

- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;

- (void)drawImage:(UIImage *)image atPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode
            alpha:(CGFloat)alpha offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;

- (void)drawImage:(UIImage *)image inRect:(CGRect)rect;

- (void)drawImage:(UIImage *)image inRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

- (void)drawImage:(UIImage *)image asPatternInRect:(CGRect)rect;

#pragma mark - Set

/**
 是否使用抗锯齿(对于画线条时候的虚线有效)
 
 @param context context上下文
 @param shouldAntialias 是否开启抗锯齿
 */
- (void)context:(CGContextRef)context shouldAntialias:(BOOL)shouldAntialias;

@end
