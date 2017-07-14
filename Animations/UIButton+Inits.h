//
//  UIButton+Init.h
//  TechCode
//
//  Created by YouXianMing on 16/5/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Init)

#pragma mark - TitleLabel Alignment

- (void)titleLabelHorizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                    verticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                    contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets;

#pragma mark - Title Color

- (void)setNormalTitleColor:(UIColor *)color;
- (UIColor *)normalTitleColor;

- (void)setHighlightedTitleColor:(UIColor *)color;
- (UIColor *)highlightedTitleColor;

- (void)setDisabledTitleColor:(UIColor *)color;
- (UIColor *)disabledTitleColor;

- (void)setSelectedTitleColor:(UIColor *)color;
- (UIColor *)selectedTitleColor;

#pragma mark - Target.action

- (instancetype)addTarget:(id)target action:(SEL)action;

#pragma mark - Title

- (void)setNormalTitle:(NSString *)title;
- (NSString *)normalTitle;

- (void)setHighlightedTitle:(NSString *)title;
- (NSString *)highlightedTitle;

- (void)setDisabledTitle:(NSString *)title;
- (NSString *)disabledTitle;

- (void)setSelectedTitle:(NSString *)title;
- (NSString *)selectedTitle;

#pragma mark - Image

- (void)setNormalImage:(UIImage *)image;
- (UIImage *)normalImage;

- (void)setHighlightedImage:(UIImage *)image;
- (UIImage *)highlightedImage;

- (void)setDisabledImage:(UIImage *)image;
- (UIImage *)disabledImage;

- (void)setSelectedImage:(UIImage *)image;
- (UIImage *)selectedImage;

#pragma mark - BackgroundImage

- (void)setBackgroundNormalImage:(UIImage *)image;
- (UIImage *)backgroundNormalImage;

- (void)setBackgroundHighlightedImage:(UIImage *)image;
- (UIImage *)backgroundHighlightedImage;

- (void)setBackgroundDisabledImage:(UIImage *)image;
- (UIImage *)backgroundDisabledImage;

- (void)setBackgroundSelectedImage:(UIImage *)image;
- (UIImage *)backgroundSelectedImage;

@end
