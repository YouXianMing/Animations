//
//  NSArray+IndexPath.h
//  TechCode
//
//  Created by YouXianMing on 2017/8/2.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (IndexPath)

- (NSMutableArray <NSIndexPath *> *)indexPathsFirstRowFrom:(NSInteger)from section:(NSInteger)section;
- (NSMutableArray <NSIndexPath *> *)indexPathsInSection:(NSInteger)section;

@end


@interface NSIndexPath (IndexPath)

+ (NSMutableArray <NSIndexPath *> *)indexPathsWithRange:(NSRange)range section:(NSInteger)section;
+ (NSMutableArray <NSIndexPath *> *)indexPathsWithArray:(NSArray *)array section:(NSInteger)section;

@end
