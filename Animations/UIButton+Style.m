//
//  UIButton+Style.m
//  Animations
//
//  Created by YouXianMing on 16/1/8.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIButton+Style.h"

@implementation UIButton (Style)

- (void)titleLabelHorizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                    verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                    contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {

    self.contentHorizontalAlignment = horizontalAlignment;
    self.contentVerticalAlignment   = verticalAlignment;
    self.contentEdgeInsets          = contentEdgeInsets;
}

- (void)titleLabelColorWithNormalStateColor:(nullable UIColor *)normalStateColor
                      highlightedStateColor:(nullable UIColor *)highlightedStateColor
                         disabledStateColor:(nullable UIColor *)disabledStateColor {

    if (normalStateColor) {

        [self setTitleColor:normalStateColor forState:UIControlStateNormal];
    }

    if (highlightedStateColor) {
        
        [self setTitleColor:highlightedStateColor forState:UIControlStateHighlighted];
    }
    
    if (disabledStateColor) {
        
        [self setTitleColor:disabledStateColor forState:UIControlStateDisabled];
    }
}

- (void)buttonSolidBackgroundColorWithNormalStateColor:(nullable UIColor *)normalStateColor
                                 highlightedStateColor:(nullable UIColor *)highlightedStateColor
                                    disabledStateColor:(nullable UIColor *)disabledStateColor {
    
    if (normalStateColor) {
        
        [self setBackgroundImage:[self imageWithSize:CGSizeMake(5, 5) color:normalStateColor]      forState:UIControlStateNormal];
    }

    if (highlightedStateColor) {

        [self setBackgroundImage:[self imageWithSize:CGSizeMake(5, 5) color:highlightedStateColor] forState:UIControlStateHighlighted];
    }

    if (disabledStateColor) {

        [self setBackgroundImage:[self imageWithSize:CGSizeMake(5, 5) color:disabledStateColor]    forState:UIControlStateDisabled];
    }
}

#pragma mark - Private method.

- (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color {
    
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
