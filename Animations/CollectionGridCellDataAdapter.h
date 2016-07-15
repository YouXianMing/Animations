//
//  CollectionGridCellDataAdapter.h
//  CollectionView
//
//  Created by YouXianMing on 16/7/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CollectionGridCellDataAdapter : NSObject

@property (nonatomic, strong) id             data;
@property (nonatomic, strong) NSString      *cellReuseIdentifier;
@property (nonatomic, weak)   NSIndexPath   *indexPath;
@property (nonatomic)         NSInteger      cellType;

+ (instancetype)collectionGridCellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifier
                                                                data:(id)data
                                                            cellType:(NSInteger)cellType;

@end

NS_INLINE CollectionGridCellDataAdapter *collectionGridCellDataAdapter(NSString *cellReuseIdentifier, id data, NSInteger type) {

    return [CollectionGridCellDataAdapter collectionGridCellDataAdapterWithCellReuseIdentifier:cellReuseIdentifier
                                                                                          data:data cellType:type];
}
