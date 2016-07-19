//
//  CollectionGridView.h
//  CollectionView
//
//  Created by YouXianMing on 16/7/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionGridCellDataAdapter.h"
#import "CustomCollectionGridViewCell.h"
@class CollectionGridView;
@class CollectionGridViewCellClassType;

#pragma mark - CollectionGridViewDelegate

@protocol CollectionGridViewDelegate <NSObject>

@optional

/**
 *  CollectionGridView did selected event.
 *
 *  @param collectionGridView CollectionGridView's object.
 *  @param cell               CustomCollectionGridViewCell type's cell.
 */
- (void)collectionGridView:(CollectionGridView *)collectionGridView didSelectedCell:(CustomCollectionGridViewCell *)cell;

@end

#pragma mark - CollectionGridView Class

@interface CollectionGridView : UIView

/**
 *  CollectionGridView's delegate.
 */
@property (nonatomic, weak) id <CollectionGridViewDelegate> delegate;

/**
 *  Content edgeInsets, default is UIEdgeInsetsMake(5, 5, 5, 5).
 */
@property (nonatomic) UIEdgeInsets contentEdgeInsets;

/**
 *  Horizontal item's gap, default is 5.f.
 */
@property (nonatomic) CGFloat horizontalGap;

/**
 *  Vertical item's gap, default is 5.f.
 */
@property (nonatomic) CGFloat verticalGap;

/**
 *  Item's height, default is 20.f.
 */
@property (nonatomic) CGFloat gridHeight;

/**
 *  The cell's count at the horizontal direction, default is 3.
 */
@property (nonatomic) NSUInteger horizontalCellCount;

/**
 *  Register the cells.
 */
@property (nonatomic, strong) NSArray <CollectionGridViewCellClassType *> *registerCells;

/**
 *  The cells data adapter.
 */
@property (nonatomic, strong) NSArray <CollectionGridCellDataAdapter *> *adapters;

/**
 *  To make the config effective.
 */
- (void)makeTheConfigEffective;

/**
 *  Reset the view's size.
 */
- (void)resetSize;

/**
 *  Get the cell's size.
 */
@property (nonatomic, readonly) CGSize cellSize;

/**
 *  Get the CollectionView's content size.
 */
@property (nonatomic, readonly) CGSize contentSize;

/**
 *  Reloads just the items at the specified index paths.
 *
 *  @param indexPaths An array of NSIndexPath objects identifying the items you want to update.
 */
- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 *  Reload data.
 */
- (void)reloadData;

@end

#pragma mark - CollectionGridViewCellClassType Class

@interface CollectionGridViewCellClassType : NSObject

@property (nonatomic)         Class      className;
@property (nonatomic, strong) NSString  *reuseIdentifier;

@end

NS_INLINE CollectionGridViewCellClassType *gridViewCellClassType(Class className, NSString  *reuseIdentifier) {
    
    CollectionGridViewCellClassType *type = [CollectionGridViewCellClassType new];
    type.className                        = className;
    type.reuseIdentifier                  = reuseIdentifier;
    
    return type;
}


