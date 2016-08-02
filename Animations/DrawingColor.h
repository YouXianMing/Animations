//
//  DrawingColor.h
//  DrawRectObject
//
//  Created by YouXianMing on 16/7/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrawingColor : NSObject

/**
 *  取值范围都在 0 - 1 之间
 */
@property (nonatomic) CGFloat  red;
@property (nonatomic) CGFloat  green;
@property (nonatomic) CGFloat  blue;
@property (nonatomic) CGFloat  alpha;

/**
 *  初始化颜色对象
 *
 *  @param red   红
 *  @param green 绿
 *  @param blue  蓝
 *  @param alpha 透明度
 *
 *  @return 颜色对象
 */
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 *  由UIColor初始化RGBColor
 *
 *  @param color
 *
 *  @return 实例对象
 */
+ (instancetype)colorWithUIColor:(UIColor *)color;

/**
 *  随机颜色(RGB)
 *
 *  @return 实例对象
 */
+ (instancetype)randomColorWithAlpha:(CGFloat)alpha;

@end
