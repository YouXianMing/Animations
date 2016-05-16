//
//  UIButton+inits.h
//  BaseController
//
//  Created by YouXianMing on 15/7/17.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    kButtonNormal,
    kButtonRed,
    
} EButtonType;

@interface UIButton (inits)

/**
 *  创建button
 *
 *  @param frame    frame值
 *  @param type     类型
 *  @param title    标题
 *  @param tag      标签
 *  @param target   目标
 *  @param selector 执行句柄
 *
 *  @return 创建好的button
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                         buttonType:(EButtonType)type
                              title:(NSString *)title
                                tag:(NSInteger)tag
                             target:(id)target
                             action:(SEL)selector;

/**
 *  设置高亮图片
 *
 *  @param image 高亮图片
 */
- (void)setHighlightedImage:(UIImage *)image;

/**
 *  返回高亮图片
 *
 *  @return 高亮图片
 */
- (UIImage *)highlightedImage;

/**
 *  设置普通图片
 *
 *  @param image 普通图片
 */
- (void)setNormalImage:(UIImage *)image;

/**
 *  返回普通图片
 *
 *  @return 普通图片
 */
- (UIImage *)normalImage;

/**
 *  设置选中的图片
 *
 *  @param image 选中的图片
 */
- (void)setSelectedImage:(UIImage *)image;

/**
 *  返回选中的图片
 *
 *  @return 选中的图片
 */
- (UIImage *)selectedImage;

@end
