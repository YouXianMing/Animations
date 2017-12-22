//
//  KernAttributeConfig.m
//  FamousQuotes
//
//  Created by YouXianMing on 2017/12/22.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "KernAttributeConfig.h"

@implementation KernAttributeConfig

- (NSString *)attributeName {
    
    return NSKernAttributeName;
}

- (id)attributeValue {

    return self.kern;
}

+ (instancetype)configWithKern:(NSNumber *)kern range:(NSRange)range {
    
    KernAttributeConfig *config = [[self class] new];
    config.kern                 = kern;
    config.effectiveStringRange = range;
    
    return config;
}

+ (instancetype)configWithKern:(NSNumber *)kern {
    
    KernAttributeConfig *config = [[self class] new];
    config.kern                 = kern;
    
    return config;
}

@end
