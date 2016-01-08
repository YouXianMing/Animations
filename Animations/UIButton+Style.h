//
//  UIButton+Style.h
//  Animations
//
//  Created by YouXianMing on 16/1/8.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Style)

/**
 *  Set the titleLabel's alignment.
 *
 *  @param horizontalAlignment UIControlContentHorizontalAlignment's value.
 *  @param verticalAlignment   UIControlContentVerticalAlignment's value.
 *  @param contentEdgeInsets   UIEdgeInsets value.
 */
- (void)titleLabelHorizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                    verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                    contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets;

/**
 *  Set the titleLabel different state's color.
 *
 *  @param normalStateColor      Normal state color.
 *  @param highlightedStateColor Highlighted state color.
 *  @param disabledStateColor    Disabled state color.
 */
- (void)titleLabelColorWithNormalStateColor:(nullable UIColor *)normalStateColor
                      highlightedStateColor:(nullable UIColor *)highlightedStateColor
                         disabledStateColor:(nullable UIColor *)disabledStateColor;

/**
 *  Set the button's solod backgroundColor.
 *
 *  @param normalStateColor      Normal state color.
 *  @param highlightedStateColor Highlighted state color.
 *  @param disabledStateColor    Disabled state color.
 */
- (void)buttonSolidBackgroundColorWithNormalStateColor:(nullable UIColor *)normalStateColor
                                 highlightedStateColor:(nullable UIColor *)highlightedStateColor
                                    disabledStateColor:(nullable UIColor *)disabledStateColor;

@end
