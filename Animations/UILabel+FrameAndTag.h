//
//  UILabel+FrameAndTag.h
//  SetRect
//
//  Created by YouXianMing on 16/6/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessViewTagProtocol.h"

@interface UILabel (FrameAndTag)

/**
 *  设置左对齐文本以及tag值(尺寸跟view尺寸一致)
 */
+ (instancetype)oneLineLeftAlignmentLabelInsertIntoView:(UIView *)view
                                                    tag:(NSInteger)tag
                                             attachedTo:(id <AccessViewTagProtocol>)object
                                                   text:(NSString *)text
                                                   font:(UIFont *)font
                                              textColor:(UIColor *)color
                                             setupBlock:(ViewSetupBlock)block;

/**
 *  设置右对齐文本以及tag值(尺寸跟view尺寸一致)
 */
+ (instancetype)oneLineRightAlignmentLabelInsertIntoView:(UIView *)view
                                                     tag:(NSInteger)tag
                                              attachedTo:(id <AccessViewTagProtocol>)object
                                                    text:(NSString *)text
                                                    font:(UIFont *)font
                                               textColor:(UIColor *)color
                                              setupBlock:(ViewSetupBlock)block;

/**
 *  设置居中对齐文本以及tag值
 */
+ (instancetype)oneLineCenterAlignmentLabelInsertIntoView:(UIView *)view
                                                positionY:(CGFloat)positionY
                                                   height:(CGFloat)height
                                                      tag:(NSInteger)tag
                                               attachedTo:(id <AccessViewTagProtocol>)object
                                                     text:(NSString *)text
                                                     font:(UIFont *)font
                                                textColor:(UIColor *)color
                                               setupBlock:(ViewSetupBlock)block;

/**
 *  设置左对齐文本(尺寸跟view尺寸一致)
 */
+ (instancetype)oneLineLeftAlignmentLabelInsertIntoView:(UIView *)view
                                                   text:(NSString *)text
                                                   font:(UIFont *)font
                                              textColor:(UIColor *)color
                                             setupBlock:(ViewSetupBlock)block;

/**
 *  设置右对其文本(尺寸跟view尺寸一致)
 */
+ (instancetype)oneLineRightAlignmentLabelInsertIntoView:(UIView *)view
                                                    text:(NSString *)text
                                                    font:(UIFont *)font
                                               textColor:(UIColor *)color
                                              setupBlock:(ViewSetupBlock)block;

/**
 *  设置居中对齐文本
 */
+ (instancetype)oneLineCenterAlignmentLabelInsertIntoView:(UIView *)view
                                                positionY:(CGFloat)positionY
                                                   height:(CGFloat)height
                                                     text:(NSString *)text
                                                     font:(UIFont *)font
                                                textColor:(UIColor *)color
                                               setupBlock:(ViewSetupBlock)block;

@end
