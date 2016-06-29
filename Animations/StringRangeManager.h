//
//  StringRangeManager.h
//  NSString
//
//  Created by YouXianMing on 16/5/22.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Range.h"

@interface StringRangeManager : NSObject

/**
 *  The full content.
 */
@property (nonatomic, strong) NSString *content;

/**
 *  The full content range.
 */
@property (nonatomic, readonly) NSRange contentRange;

/**
 *  Part of the content.
 */
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSString *>  *parts;

/**
 *  Get the ranges from the part.
 *
 *  @param partName part name.
 *  @param mask     mask.
 *
 *  @return Ranges.
 */
- (NSArray *)rangesFromPartName:(NSString *)partName options:(NSStringCompareOptions)mask;

/**
 *  Get the StringRangeManager object.
 *
 *  @param content The full content.
 *  @param parts   Part of the content's dictionary.
 *
 *  @return StringRangeManager.
 */
+ (instancetype)stringRangeManagerWithContent:(NSString *)content parts:(NSDictionary *)parts;

@end
