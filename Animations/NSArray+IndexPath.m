//
//  NSArray+IndexPath.m
//  TechCode
//
//  Created by YouXianMing on 2017/8/2.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "NSArray+IndexPath.h"

@implementation NSArray (IndexPath)

- (NSMutableArray <NSIndexPath *> *)indexPathsFirstRowFrom:(NSInteger)from section:(NSInteger)section {
    
    NSMutableArray *array = [NSMutableArray array];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [array addObject:[NSIndexPath indexPathForRow:idx + from inSection:section]];
    }];
    
    return array;
}

- (NSMutableArray <NSIndexPath *> *)indexPathsInSection:(NSInteger)section {
    
    return [self indexPathsFirstRowFrom:0 section:section];
}

@end

@implementation NSIndexPath (IndexPath)

+ (NSMutableArray <NSIndexPath *> *)indexPathsWithRange:(NSRange)range section:(NSInteger)section {
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = range.location; i < range.length; i++) {
        
        [array addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    return array;
}

+ (NSMutableArray <NSIndexPath *> *)indexPathsWithArray:(NSArray *)array section:(NSInteger)section {
    
    NSRange range = NSMakeRange(0, array.count);
    return [self indexPathsWithRange:range section:section];
}

@end
