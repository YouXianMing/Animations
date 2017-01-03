//
//  IndexRange.h
//  RangeMaker
//
//  Created by YouXianMing on 2017/1/3.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IndexRange : NSObject

@property (nonatomic) NSUInteger section;
@property (nonatomic) NSUInteger location;
@property (nonatomic) NSUInteger length;

+ (NSMutableArray <NSIndexPath *> *)indexPathsFromIndexRanges:(NSArray <IndexRange *> *)indexRanges;

@end

NS_INLINE IndexRange * MakeIndexRange(NSUInteger loc, NSUInteger len, NSUInteger section) {
    
    IndexRange *r = [IndexRange new];
    r.location    = loc;
    r.length      = len;
    r.section     = section;
    
    return r;
}

NS_INLINE NSMutableArray <NSIndexPath *> * MakeIndexRanges(NSArray <IndexRange *> *indexRanges) {
    
    return [IndexRange indexPathsFromIndexRanges:indexRanges];
}
