//
//  CustomIrregularGridViewCell.h
//  IrregularGridCollectionView
//
//  Created by YouXianMing on 16/8/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IrregularGridCellDataAdapter.h"
@class IrregularGridCollectionView;

@interface CustomIrregularGridViewCell : UICollectionViewCell

@property (nonatomic, weak) id                              data;
@property (nonatomic, weak) IrregularGridCellDataAdapter   *dataAdapter;
@property (nonatomic, weak) UICollectionView               *collectionView;
@property (nonatomic, weak) NSIndexPath                    *indexPath;
@property (nonatomic, weak) IrregularGridCollectionView    *collectionGridView;

#pragma mark - Method you should overwrite.

/**
 *  Setup cell, override by subclass.
 */
- (void)setupCell;

/**
 *  Build subview, override by subclass.
 */
- (void)buildSubview;

/**
 *  Load content, override by subclass.
 */
- (void)loadContent;

/**
 *  Selected event, override by subclass.
 */
- (void)selectedEvent;

#pragma mark - Constructor.

+ (IrregularGridCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type
                                                           itemWidth:(CGFloat)itemWidth;
+ (IrregularGridCellDataAdapter *)dataAdapterWithData:(id)data type:(NSInteger)type itemWidth:(CGFloat)itemWidth;

@end
