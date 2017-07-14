//
//  UIButton+Init.m
//  TechCode
//
//  Created by YouXianMing on 16/5/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIButton+Inits.h"

@implementation UIButton (Init)

#pragma mark - TitleLabel Alignment

- (void)titleLabelHorizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                    verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                    contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    
    self.contentHorizontalAlignment = horizontalAlignment;
    self.contentVerticalAlignment   = verticalAlignment;
    self.contentEdgeInsets          = contentEdgeInsets;
}

#pragma mark - Target.action

- (instancetype)addTarget:(id)target action:(SEL)action {
    
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return self;
}

#pragma mark - Title Color

- (void)setNormalTitleColor:(UIColor *)color {
    
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (UIColor *)normalTitleColor {
    
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setHighlightedTitleColor:(UIColor *)color {
    
    [self setTitleColor:color forState:UIControlStateHighlighted];
}

- (UIColor *)highlightedTitleColor {
    
    return [self titleColorForState:UIControlStateHighlighted];
}

- (void)setDisabledTitleColor:(UIColor *)color {
    
    [self setTitleColor:color forState:UIControlStateDisabled];
}

- (UIColor *)disabledTitleColor {
    
    return [self titleColorForState:UIControlStateDisabled];
}

- (void)setSelectedTitleColor:(UIColor *)color {
    
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (UIColor *)selectedTitleColor {
    
    return [self titleColorForState:UIControlStateSelected];
}

#pragma mark - Title

- (void)setNormalTitle:(NSString *)title {
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (NSString *)normalTitle {
    
    return [self titleForState:UIControlStateNormal];
}

- (void)setHighlightedTitle:(NSString *)title {
    
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (NSString *)highlightedTitle {
    
    return [self titleForState:UIControlStateHighlighted];
}

- (void)setDisabledTitle:(NSString *)title {
    
    [self setTitle:title forState:UIControlStateDisabled];
}

- (NSString *)disabledTitle {
    
    return [self titleForState:UIControlStateDisabled];
}

- (void)setSelectedTitle:(NSString *)title {
    
    [self setTitle:title forState:UIControlStateSelected];
}

- (NSString *)selectedTitle {
    
    return [self titleForState:UIControlStateSelected];
}

#pragma mark - Image

- (void)setHighlightedImage:(UIImage *)image {
    
    [self setImage:image forState:UIControlStateHighlighted];
}

- (UIImage *)highlightedImage {
    
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setSelectedImage:(UIImage *)image {
    
    [self setImage:image forState:UIControlStateSelected];
}

- (UIImage *)selectedImage {
    
    return [self imageForState:UIControlStateSelected];
}

- (void)setNormalImage:(UIImage *)image {
    
    [self setImage:image forState:UIControlStateNormal];
}

- (UIImage *)normalImage {
    
    return [self imageForState:UIControlStateNormal];
}

- (void)setDisabledImage:(UIImage *)image {
    
    [self setImage:image forState:UIControlStateDisabled];
}

- (UIImage *)disabledImage {
    
    return [self imageForState:UIControlStateDisabled];
}

#pragma mark - BackgroundImage

- (void)setBackgroundNormalImage:(UIImage *)image {
    
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

- (UIImage *)backgroundNormalImage {
    
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setBackgroundHighlightedImage:(UIImage *)image {
    
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
}

- (UIImage *)backgroundHighlightedImage {
    
    return [self backgroundImageForState:UIControlStateHighlighted];
}

- (void)setBackgroundDisabledImage:(UIImage *)image {
    
    [self setBackgroundImage:image forState:UIControlStateDisabled];
}

- (UIImage *)backgroundDisabledImage {
    
    return [self backgroundImageForState:UIControlStateDisabled];
}

- (void)setBackgroundSelectedImage:(UIImage *)image {
    
    [self setBackgroundImage:image forState:UIControlStateSelected];
}

- (UIImage *)backgroundSelectedImage {
    
    return [self backgroundImageForState:UIControlStateSelected];
}

@end
