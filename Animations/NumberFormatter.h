//
//  NumberFormatter.h
//  ZiPeiYi
//
//  Created by YouXianMing on 16/1/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NumberFormatter : NSObject

/**
 *  Get percent style value string(eg: 0.12 -> 12%).
 *
 *  @param value                 Input value.
 *  @param maximumFractionDigits Maximum fraction digits.
 *  @param minimumFractionDigits Minimum fraction digits.
 *  @param roundingMode          NSNumberFormatterRoundingMode.
 *
 *  @return Percent style value string.
 */
+ (NSString *)PercentStyleWithValue:(CGFloat)value
              maximumFractionDigits:(NSUInteger)maximumFractionDigits
              minimumFractionDigits:(NSUInteger)minimumFractionDigits
                       roundingMode:(NSNumberFormatterRoundingMode)roundingMode;

/**
 *  Get decimal style value string.(eg: 23 -> 23.00)
 *
 *  @param value                 Input value.
 *  @param maximumFractionDigits Maximum fraction digits.
 *  @param minimumFractionDigits Minimum fraction digits.
 *  @param roundingMode          NSNumberFormatterRoundingMode.
 *
 *  @return Percent style value string.
 */
+ (NSString *)decimalStyleWithValue:(CGFloat)value
              maximumFractionDigits:(NSUInteger)maximumFractionDigits
              minimumFractionDigits:(NSUInteger)minimumFractionDigits
                       roundingMode:(NSNumberFormatterRoundingMode)roundingMode;

@end
