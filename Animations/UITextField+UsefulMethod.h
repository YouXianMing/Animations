//
//  UITextField+UsefulMethod.h
//  TechCode
//
//  Created by YouXianMing on 16/5/20.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (UsefulMethod)

/**
 *  当前的字符串
 */
@property (nonatomic, strong) NSMutableString  *currentString;

/**
 *  密码键盘的特殊处理（在代理方法 textFieldDidBeginEditing: 中调用）
 */
- (void)secureTextFieldDidBeginEditing;

/**
 *  获取当前显示字符串（在代理方法 textField:shouldChangeCharactersInRange:replacementString: 中调用）
 */
- (NSString *)changeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**
 *  添加AccessoryView
 *
 *  @param title 按钮标题
 */
- (void)addInputAccessoryViewButtonWithTitle:(NSString *)title;

@end
