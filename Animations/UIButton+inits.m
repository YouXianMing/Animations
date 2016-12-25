//
//  UIButton+inits.m
//  BaseController
//
//  Created by YouXianMing on 15/7/17.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "UIButton+inits.h"

@implementation UIButton (inits)

- (void)addTarget:(id)target touchUpInsideAction:(SEL)action {

    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

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

- (void)setNormalImage:(UIImage *)image {
    
    [self setImage:image forState:UIControlStateNormal];
}

- (UIImage *)normalImage {
    
    return [self imageForState:UIControlStateNormal];
}

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

@end
