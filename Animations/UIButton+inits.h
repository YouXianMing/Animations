//
//  UIButton+inits.h
//  BaseController
//
//  Created by YouXianMing on 15/7/17.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (inits)

/**
 Associates a target object and action method with the UIControlEventTouchUpInside.

 @param target Target object.
 @param action The action.
 */
- (void)addTarget:(id)target touchUpInsideAction:(SEL)action;

/**
 *  Set highlighted image.
 *
 *  @param image Image object.
 */
- (void)setHighlightedImage:(UIImage *)image;

/**
 *  Get the highlighted image.
 *
 *  @return Highlighted image.
 */
- (UIImage *)highlightedImage;

/**
 *  Set normal image.
 *
 *  @param image Normal image.
 */
- (void)setNormalImage:(UIImage *)image;

/**
 *  Get the normal image.
 *
 *  @return Normal image.
 */
- (UIImage *)normalImage;

/**
 *  Set selected image.
 *
 *  @param image Selected image.
 */
- (void)setSelectedImage:(UIImage *)image;

/**
 *  Get the selected image.
 *
 *  @return Selected image.
 */
- (UIImage *)selectedImage;

/**
 *  Set normal title.
 *
 *  @param title Normal title.
 */
- (void)setNormalTitle:(NSString *)title;

/**
 *  Get the normal title.
 *
 *  @return Normal title.
 */
- (NSString *)normalTitle;

/**
 *  Set highlighted title.
 *
 *  @param title Title.
 */
- (void)setHighlightedTitle:(NSString *)title;

/**
 *  Get the highlighted title.
 *
 *  @return Highlighted title.
 */
- (NSString *)highlightedTitle;

@end
