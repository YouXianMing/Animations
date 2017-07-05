//
//  FontAttributeConfig.m
//  AttributedString
//
//  Created by YouXianMing on 2017/6/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "FontAttributeConfig.h"

@implementation FontAttributeConfig

- (NSString *)attributeName {
    
    return NSFontAttributeName;
}

- (id)attributeValue {
    
    if (self.font) {
        
        return self.font;
        
    } else {
        
        return [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
}

+ (instancetype)configWithFont:(UIFont *)font range:(NSRange)range {
    
    FontAttributeConfig *config = [[self class] new];
    config.font                 = font;
    config.effectiveStringRange = range;
    
    return config;
}

+ (instancetype)configWithFont:(UIFont *)font {
    
    FontAttributeConfig *config = [[self class] new];
    config.font                 = font;
    
    return config;
}

@end
