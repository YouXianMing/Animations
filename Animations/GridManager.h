//
//  GridManager.h
//  GridLayoutManager
//
//  Created by YouXianMing on 16/5/4.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GridManager : NSObject

@property (nonatomic, strong) NSArray <NSNumber *>  *rowHeights;
@property (nonatomic)         UIEdgeInsets           edgeInsets;
@property (nonatomic)         CGFloat                gap;

- (void)reset;
- (void)prepare;
- (CGSize)contentSize;
- (void)addElement:(NSNumber *)width;
- (NSArray *)allElements;
- (NSArray *)allFrames;
- (CGRect)frameByIndex:(NSInteger)index;

@end
