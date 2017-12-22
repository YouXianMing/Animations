//
//  KernAttributeConfig.h
//  FamousQuotes
//
//  Created by YouXianMing on 2017/12/22.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "AttributedStringConfig.h"

@interface KernAttributeConfig : AttributedStringConfig

@property (nonatomic, strong) NSNumber *kern;

+ (instancetype)configWithKern:(NSNumber *)kern range:(NSRange)range;
+ (instancetype)configWithKern:(NSNumber *)kern;

@end
