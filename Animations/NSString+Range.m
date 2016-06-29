//
//  NSString+Range.m
//  NSString
//
//  Created by YouXianMing on 16/5/22.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "NSString+Range.h"

@implementation NSString (Range)

- (NSArray <NSValue *> *)rangesOfString:(NSString *)searchString options:(NSStringCompareOptions)mask serachRange:(NSRange)range {

    NSMutableArray *array = [NSMutableArray array];
    [self rangeOfString:searchString range:NSMakeRange(0, self.length) array:array options:mask];
    
    return array;
}

- (void)rangeOfString:(NSString *)searchString
                range:(NSRange)searchRange
                array:(NSMutableArray *)array
              options:(NSStringCompareOptions)mask {

    NSRange range = [self rangeOfString:searchString options:mask range:searchRange];
    
    if (range.location != NSNotFound) {
        
        [array addObject:[NSValue valueWithRange:range]];
        [self rangeOfString:searchString
                      range:NSMakeRange(range.location + range.length, self.length - (range.location + range.length))
                      array:array
                    options:mask];
    }
}

@end
