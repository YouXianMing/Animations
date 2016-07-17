//
//  CustomCollectionGridViewCell.h
//  CollectionView
//
//  Created by YouXianMing on 16/7/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionGridCellDataAdapter.h"
@class CollectionGridView;

@interface CustomCollectionGridViewCell : UICollectionViewCell

@property (nonatomic, weak) id                              data;
@property (nonatomic, weak) CollectionGridCellDataAdapter  *dataAdapter;
@property (nonatomic, weak) UICollectionView               *collectionView;
@property (nonatomic, weak) NSIndexPath                    *indexPath;
@property (nonatomic, weak) CollectionGridView             *collectionGridView;

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

+ (CollectionGridCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                                 data:(id)data
                                                                 type:(NSInteger)type;

@end
