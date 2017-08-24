//
//  DrawingAttribute.h
//  CGContext
//
//  Created by YouXianMing on 2017/8/23.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrawingAttribute : NSObject

/**
 *  线条的头与尾的样式
 */
@property (nonatomic) CGLineCap lineCap;

/**
 *  线条折线部分的样式
 */
@property (nonatomic) CGLineJoin lineJoin;

/**
 *  线条宽度
 */
@property (nonatomic) CGFloat lineWidth;

#pragma mark - stroke & fill color

/**
 *  path绘制颜色
 */
@property (nonatomic, strong) UIColor *strokeColor;

/**
 *  path填充颜色
 */
@property (nonatomic, strong) UIColor *fillColor;

#pragma mark - line dash pattern

/**
 *  Line dash pattern [Example]
 *
 *  - one type -
 *
 *  self.lineDashLengths = @[@(5)];
 *  self.phase           = 0;
 *
 *  - default -
 *
 *  self.lineDashLengths = nil;
 *  self.phase           = 0;
 */

/**
 *  A value that specifies how far into the dash pattern the line starts, in units of the user space. 
 *  For example, passing a value of 3 means the line is drawn with the dash pattern starting at three
 *  units from its beginning. Passing a value of 0 draws a line starting with the beginning of a dash 
 *  pattern.
 */
@property (nonatomic) CGFloat phase;

/**
 *  An array of values that specify the lengths of the painted segments and unpainted segments, 
 *  respectively, of the dash pattern—or NULL for no dash pattern.
 */
@property (nonatomic) NSArray <NSNumber *> *lineDashLengths;

@end
