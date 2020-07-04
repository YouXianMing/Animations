//
//  NSArray+Split.m
//  AjMall
//
//  Created by YouXianMing on 2019/11/12.
//  Copyright © 2019 YouXianMing. All rights reserved.
//

#import "NSArray+Split.h"

@implementation NSArray (Split)

- (NSArray <NSArray *> *)splitWithCount:(NSInteger)count {
    
    NSMutableArray *arrayOfArrays = [NSMutableArray array];
    
    if (self.count && count) {
        
        NSUInteger itemsRemaining = self.count;
        
        int j = 0;
        while (itemsRemaining) {
            
            NSRange  range     = NSMakeRange(j, MIN(count, itemsRemaining));
            NSArray *subLogArr = [self subarrayWithRange:range];
            [arrayOfArrays addObject:subLogArr];
            
            itemsRemaining -= range.length;
            j              += range.length;
        }
        
    } else if (count <= 0) {
        
        [arrayOfArrays addObject:self];
    }
    
    return [NSArray arrayWithArray:arrayOfArrays];
}

@end
