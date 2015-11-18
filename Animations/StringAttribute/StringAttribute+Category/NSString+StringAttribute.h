//
//  NSString+StringAttribute.h
//  AttributeString
//
//  Created by YouXianMing on 15/8/3.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringAttributeProtocol.h"

@interface NSString (StringAttribute)

/**
 *  创建可变富文本(可以设置富文本局部的值,协议对象的range值有效)
 *
 *  @param attributes 所有实现了StringAttributeProtocol协议的对象(协议中的对象需要设置range值)
 *
 *  @return 可变富文本
 */
- (NSMutableAttributedString *)mutableAttributedStringWithStringAttributes:(NSArray *)attributes;

/**
 *  创建不可变富文本(所有的设置都是全局设置,协议对象的range值无效)
 *
 *  @param attributes 所有实现了StringAttributeProtocol协议的对象(协议中的对象不需要设置range值)
 *
 *  @return 不可变富文本
 */
- (NSAttributedString *)attributedStringWithStringAttributes:(NSArray *)attributes;

@end
