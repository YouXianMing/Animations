//
//  CellAttributesManager.m
//  AjMall
//
//  Created by YouXianMing on 2019/8/12.
//  Copyright © 2019 YouXianMing. All rights reserved.
//

#import "CellAttributesManager.h"

@interface CellAttributesManager ()

@property (nonatomic) NSMutableArray <NSMutableArray <UICollectionViewLayoutAttributes *> *> *attributesArray;

@end

@implementation CellAttributesManager

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.attributesArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)buildAnAttributesArray {
    
    NSMutableArray *array = [NSMutableArray array];
    [self.attributesArray addObject:array];
}

- (void)addAttributes:(UICollectionViewLayoutAttributes *)attributes {
    
    [self.attributesArray.lastObject addObject:attributes];
}

@end
