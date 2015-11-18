//
//  NSString+StringAttribute.m
//  AttributeString
//
//  Created by YouXianMing on 15/8/3.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "NSString+StringAttribute.h"

@implementation NSString (StringAttribute)

- (NSMutableAttributedString *)mutableAttributedStringWithStringAttributes:(NSArray *)attributes {
    
    NSMutableAttributedString *attributedString = nil;
    
    if (self) {

        attributedString = [[NSMutableAttributedString alloc] initWithString:self];
        
        for (id <StringAttributeProtocol> attribute in attributes) {

            [attributedString addAttribute:[attribute attributeName]
                                     value:[attribute attributeValue]
                                     range:[attribute effectiveStringRange]];
        }
    }
    
    return attributedString;
}

- (NSAttributedString *)attributedStringWithStringAttributes:(NSArray *)attributes {

    NSAttributedString *attributedString = nil;
    
    if (self) {
        
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        
        for (id <StringAttributeProtocol> attribute in attributes) {
            
            [attributesDictionary setObject:[attribute attributeValue]
                                     forKey:[attribute attributeName]];
        }
        
        attributedString = [[NSAttributedString alloc] initWithString:self
                                                           attributes:attributesDictionary];
    }
    
    return attributedString;
}

@end
