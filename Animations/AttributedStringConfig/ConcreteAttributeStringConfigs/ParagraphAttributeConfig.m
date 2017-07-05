//
//  ParagraphAttributeConfig.m
//  AttributedString
//
//  Created by YouXianMing on 2017/6/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ParagraphAttributeConfig.h"

@implementation ParagraphAttributeConfig

- (NSString *)attributeName {
    
    return NSParagraphStyleAttributeName;
}

- (id)attributeValue {
    
    if (self.paragraphStyle) {
        
        return self.paragraphStyle;
        
    } else {
        
        return [NSParagraphStyle defaultParagraphStyle];
    }
}

+ (instancetype)configWithParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range {
    
    ParagraphAttributeConfig *config = [[self class] new];
    config.paragraphStyle            = paragraphStyle;
    config.effectiveStringRange = range;
    
    return config;
}

+ (instancetype)configWithParagraphStyle:(NSParagraphStyle *)paragraphStyle {
    
    ParagraphAttributeConfig *config = [[self class] new];
    config.paragraphStyle            = paragraphStyle;
    
    return config;
}

@end
