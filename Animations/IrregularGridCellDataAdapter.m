//
//  IrregularGridCellDataAdapter.m
//  IrregularGridCollectionView
//
//  Created by YouXianMing on 16/8/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "IrregularGridCellDataAdapter.h"

@implementation IrregularGridCellDataAdapter

+ (instancetype)collectionGridCellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifier data:(id)data
                                                            cellType:(NSInteger)cellType itemWidth:(CGFloat)itemWidth {
    
    IrregularGridCellDataAdapter *adapter = [[self class] new];
    adapter.cellReuseIdentifier           = cellReuseIdentifier;
    adapter.data                          = data;
    adapter.cellType                      = cellType;
    adapter.itemWidth                     = itemWidth;
    
    return adapter;
}

@end
