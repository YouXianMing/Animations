//
//  IndexRange.m
//  RangeMaker
//
//  Created by YouXianMing on 2017/1/3.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "IndexRange.h"

@implementation IndexRange

+ (NSMutableArray <NSIndexPath *> *)indexPathsFromIndexRanges:(NSArray <IndexRange *> *)indexRanges {

    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (IndexRange *indexRange in indexRanges) {
        
        for (NSUInteger i = indexRange.location; i < indexRange.location + indexRange.length; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:indexRange.section]];
        }
    }
    
    return indexPaths;
}

@end
