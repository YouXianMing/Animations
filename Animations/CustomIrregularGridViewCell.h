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
@class CustomIrregularGridViewCell;

@protocol CustomIrregularGridViewCellDelegate <NSObject>

@optional

- (void)customIrregularGridViewCell:(CustomIrregularGridViewCell *)cell event:(id)event;

@end

@interface CustomIrregularGridViewCell : UICollectionViewCell

@property (nonatomic, weak) id <CustomIrregularGridViewCellDelegate> delegate;
@property (nonatomic, weak) id                                       data;
@property (nonatomic, weak) IrregularGridCellDataAdapter            *dataAdapter;
@property (nonatomic, weak) UICollectionView                        *collectionView;
@property (nonatomic, weak) NSIndexPath                             *indexPath;
@property (nonatomic, weak) IrregularGridCollectionView             *collectionGridView;

/**
 *  Selected event, you can override by subclass, you should manual call this
 *  method to make the IrregularGridCollectionView selected event effective.
 */
- (void)selectedEvent;

- (void)willDisplay;

- (void)didEndDisplay;

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

#pragma mark - Constructor.

+ (IrregularGridCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type itemWidth:(CGFloat)itemWidth;
+ (IrregularGridCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data itemWidth:(CGFloat)itemWidth;
+ (IrregularGridCellDataAdapter *)dataAdapterWithData:(id)data type:(NSInteger)type itemWidth:(CGFloat)itemWidth;
+ (IrregularGridCellDataAdapter *)dataAdapterWithData:(id)data itemWidth:(CGFloat)itemWidth;

@end
