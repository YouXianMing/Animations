//
//  CollectionGridCellDataAdapter.m
//  CollectionView
//
//  Created by YouXianMing on 16/7/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CollectionGridCellDataAdapter.h"

@implementation CollectionGridCellDataAdapter

+ (instancetype)collectionGridCellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifier
                                                                data:(id)data
                                                            cellType:(NSInteger)cellType {

    CollectionGridCellDataAdapter *adapter = [[self class] new];
    adapter.cellReuseIdentifier            = cellReuseIdentifier;
    adapter.data                           = data;
    adapter.cellType                       = cellType;
    
    return adapter;
}

@end
