//
//  ForegroundColorAttributeConfig.h
//  AttributedString
//
//  Created by YouXianMing on 2017/6/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "AttributedStringConfig.h"

@interface ForegroundColorAttributeConfig : AttributedStringConfig

@property (nonatomic, strong) UIColor *color;

+ (instancetype)configWithColor:(UIColor *)color range:(NSRange)range;
+ (instancetype)configWithColor:(UIColor *)color;

@end
