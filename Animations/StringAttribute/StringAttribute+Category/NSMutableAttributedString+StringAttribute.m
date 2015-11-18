//
//  NSMutableAttributedString+StringAttribute.m
//  AttributeString
//
//  Created by YouXianMing on 15/8/3.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "NSMutableAttributedString+StringAttribute.h"

@implementation NSMutableAttributedString (StringAttribute)

- (void)addStringAttribute:(id <StringAttributeProtocol>)stringAttribute {

    [self addAttribute:[stringAttribute attributeName]
                 value:[stringAttribute attributeValue]
                 range:[stringAttribute effectiveStringRange]];
}

- (void)removeStringAttribute:(id <StringAttributeProtocol>)stringAttribute {

    [self removeAttribute:[stringAttribute attributeName]
                    range:[stringAttribute effectiveStringRange]];
}

@end
