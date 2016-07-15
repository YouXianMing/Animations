//
//  CustomCollectionGridViewCell.h
//  CollectionView
//
//  Created by YouXianMing on 16/7/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionGridCellDataAdapter.h"

@interface CustomCollectionGridViewCell : UICollectionViewCell

@property (nonatomic, weak) id                              data;
@property (nonatomic, weak) CollectionGridCellDataAdapter  *dataAdapter;
@property (nonatomic, weak) UICollectionView               *collectionView;
@property (nonatomic, weak) NSIndexPath                    *indexPath;

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

/**
 *  Constructor to create the CollectionGridCellDataAdapter.
 *
 *  @param reuseIdentifier Cell's reuseIdentifier.
 *  @param data            Data, can be nil.
 *  @param type            Cell's type.
 *
 *  @return CollectionGridCellDataAdapter
 */
+ (CollectionGridCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type;

/**
 *  Constructor to create the CollectionGridCellDataAdapter, the reuseIdentifier is the class string.
 *
 *  @param data Data, can be nil.
 *  @param type Cell's type.
 *
 *  @return CollectionGridCellDataAdapter
 */
+ (CollectionGridCellDataAdapter *)dataAdapterWithData:(id)data type:(NSInteger)type;

/**
 *  Constructor to create the CollectionGridCellDataAdapter, the reuseIdentifier is the class string.
 *
 *  @param data Data, can be nil.
 *
 *  @return CollectionGridCellDataAdapter
 */
+ (CollectionGridCellDataAdapter *)dataAdapterWithData:(id)data;

@end
