//
//  NSMutableAttributedString+StringAttribute.h
//  AttributeString
//
//  Created by YouXianMing on 15/8/3.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringAttributeProtocol.h"

@interface NSMutableAttributedString (StringAttribute)

/**
 *  添加富文本对象
 *
 *  @param stringAttribute 实现了StringAttributeProtocol协议的对象
 */
- (void)addStringAttribute:(id <StringAttributeProtocol>)stringAttribute;

/**
 *  消除指定的富文本对象
 *
 *  @param stringAttribute 实现了StringAttributeProtocol协议的对象
 */
- (void)removeStringAttribute:(id <StringAttributeProtocol>)stringAttribute;

@end
