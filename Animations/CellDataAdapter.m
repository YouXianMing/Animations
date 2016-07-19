//
//  CellDataAdapter.m
//  ZiPeiYi
//
//  Created by YouXianMing on 15/12/30.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CellDataAdapter.h"

@implementation CellDataAdapter

+ (CellDataAdapter *)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers data:(id)data
                                                 cellHeight:(CGFloat)cellHeight cellType:(NSInteger)cellType {
    
    CellDataAdapter *adapter    = [[self class] new];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data                = data;
    adapter.cellHeight          = cellHeight;
    adapter.cellType            = cellType;
    
    return adapter;
}

+ (CellDataAdapter *)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers data:(id)data
                                                 cellHeight:(CGFloat)cellHeight cellWidth:(CGFloat)cellWidth
                                                   cellType:(NSInteger)cellType {
    
    CellDataAdapter *adapter    = [[self class] new];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data                = data;
    adapter.cellHeight          = cellHeight;
    adapter.cellWidth           = cellWidth;
    adapter.cellType            = cellType;
    
    return adapter;
}

+ (CellDataAdapter *)collectionCellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers data:(id)data cellType:(NSInteger)cellType {
    
    CellDataAdapter *adapter    = [[self class] new];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data                = data;
    adapter.cellType            = cellType;
    
    return adapter;
}

@end
