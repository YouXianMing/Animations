//
//  NumberFormatter.m
//  ZiPeiYi
//
//  Created by YouXianMing on 16/1/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "NumberFormatter.h"

@implementation NumberFormatter

+ (NSString *)PercentStyleWithValue:(CGFloat)value
              maximumFractionDigits:(NSUInteger)maximumFractionDigits
              minimumFractionDigits:(NSUInteger)minimumFractionDigits
                       roundingMode:(NSNumberFormatterRoundingMode)roundingMode {
    
    NSNumberFormatter *numFormatter    = [[NSNumberFormatter alloc] init];
    numFormatter.numberStyle           = kCFNumberFormatterPercentStyle;
    numFormatter.maximumFractionDigits = maximumFractionDigits;
    numFormatter.minimumFractionDigits = minimumFractionDigits;
    numFormatter.roundingMode          = roundingMode;
    
    return [numFormatter stringFromNumber:[NSNumber numberWithFloat:value]];
}

+ (NSString *)PercentStyleWithNumberValue:(NSNumber *)value
                    maximumFractionDigits:(NSUInteger)maximumFractionDigits
                    minimumFractionDigits:(NSUInteger)minimumFractionDigits
                             roundingMode:(NSNumberFormatterRoundingMode)roundingMode {
    
    NSNumberFormatter *numFormatter    = [[NSNumberFormatter alloc] init];
    numFormatter.numberStyle           = kCFNumberFormatterPercentStyle;
    numFormatter.maximumFractionDigits = maximumFractionDigits;
    numFormatter.minimumFractionDigits = minimumFractionDigits;
    numFormatter.roundingMode          = roundingMode;
    
    return [numFormatter stringFromNumber:value];
}

+ (NSString *)decimalStyleWithValue:(CGFloat)value
              maximumFractionDigits:(NSUInteger)maximumFractionDigits
              minimumFractionDigits:(NSUInteger)minimumFractionDigits
                       roundingMode:(NSNumberFormatterRoundingMode)roundingMode {
    
    NSNumberFormatter *numFormatter    = [[NSNumberFormatter alloc] init];
    numFormatter.numberStyle           = kCFNumberFormatterDecimalStyle;
    numFormatter.maximumFractionDigits = maximumFractionDigits;
    numFormatter.minimumFractionDigits = minimumFractionDigits;
    numFormatter.roundingMode          = roundingMode;
    
    return [numFormatter stringFromNumber:[NSNumber numberWithFloat:value]];
}

+ (NSString *)decimalStyleWithNumberValue:(NSNumber *)value
                    maximumFractionDigits:(NSUInteger)maximumFractionDigits
                    minimumFractionDigits:(NSUInteger)minimumFractionDigits
                             roundingMode:(NSNumberFormatterRoundingMode)roundingMode {
    
    NSNumberFormatter *numFormatter    = [[NSNumberFormatter alloc] init];
    numFormatter.numberStyle           = kCFNumberFormatterDecimalStyle;
    numFormatter.maximumFractionDigits = maximumFractionDigits;
    numFormatter.minimumFractionDigits = minimumFractionDigits;
    numFormatter.roundingMode          = roundingMode;
    
    return [numFormatter stringFromNumber:value];
}

@end
