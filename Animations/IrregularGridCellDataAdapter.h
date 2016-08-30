//
//  IrregularGridCellDataAdapter.h
//  IrregularGridCollectionView
//
//  Created by YouXianMing on 16/8/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IrregularGridCellDataAdapter : NSObject

/**
 *  The data.
 */
@property (nonatomic, strong) id             data;

/**
 *  The cell reused identifier.
 */
@property (nonatomic, strong) NSString      *cellReuseIdentifier;

/**
 *  The cell's index path.
 */
@property (nonatomic, weak)   NSIndexPath   *indexPath;

/**
 *  The cell's type.
 */
@property (nonatomic)         NSInteger      cellType;

/**
 *  The item width.
 */
@property (nonatomic)         CGFloat        itemWidth;

+ (instancetype)collectionGridCellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifier data:(id)data
                                                            cellType:(NSInteger)cellType itemWidth:(CGFloat)itemWidth;

@end
