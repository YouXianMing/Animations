//
//  UIView+ConvenientMethod.h
//  TechCode
//
//  Created by YouXianMing on 16/5/13.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ConvenientMethod)

/**
 *  Create Line view.
 *
 *  @param frame Frame
 *  @param color Color
 *
 *  @return Line View.
 */
+ (UIView *)lineViewWithFrame:(CGRect)frame color:(UIColor *)color;

/**
 *  Create Line view.
 *
 *  @param frame Frame
 *  @param color Color
 *  @param tag   Tag
 *
 *  @return Line View.
 */
+ (UIView *)lineViewWithFrame:(CGRect)frame color:(UIColor *)color tag:(NSInteger)tag;

@end
