//
//  NSString+Range.h
//  NSString
//
//  Created by YouXianMing on 16/5/22.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Range)

/**
 *  Finds and returns the ranges of a given string, within the given range of the receiver.
 *
 *  @param searchString searchString.
 *  @param mask         A mask specifying search options. The following options may be specified by combining them with the C bitwise OR operator: NSCaseInsensitiveSearch, NSLiteralSearch, NSBackwardsSearch, NSAnchoredSearch. See String Programming Guide for details on these options.
 *  @param range        serachRange.
 *
 *  @return Ranges.
 */
- (NSArray <NSValue *> *)rangesOfString:(NSString *)searchString options:(NSStringCompareOptions)mask serachRange:(NSRange)range;

@end
