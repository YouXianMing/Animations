//
//  NSMutableAttributedString+AttributedStringConfig.m
//  AttributedString
//
//  Created by YouXianMing on 2017/6/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "NSMutableAttributedString+AttributedStringConfig.h"

@implementation NSMutableAttributedString (AttributedStringConfig)

- (void)addStringAttribute:(AttributedStringConfig *)stringAttribute {
    
    [self addAttribute:stringAttribute.attributeName
                 value:stringAttribute.attributeValue
                 range:stringAttribute.effectiveStringRange];
}

- (void)removeStringAttribute:(AttributedStringConfig *)stringAttribute {
    
    [self removeAttribute:stringAttribute.attributeName
                    range:stringAttribute.effectiveStringRange];
}

+ (instancetype)mutableAttributedStringWithString:(NSString *)string
                                           config:(void (^)(NSString *string, NSMutableArray <AttributedStringConfig *> *configs))configBlock {
    
    NSMutableAttributedString *atbString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableArray            *array     = nil;
    
    if (configBlock) {
        
        array = [NSMutableArray array];
        configBlock(string, array);
    }
    
    [array enumerateObjectsUsingBlock:^(AttributedStringConfig *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [atbString addStringAttribute:obj];
    }];
    
    return atbString;
}

@end
