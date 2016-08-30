//
//  IrregularGridCollectionView.h
//  IrregularGridCollectionView
//
//  Created by YouXianMing on 16/8/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IrregularGridCellDataAdapter.h"
#import "MaximumSpacingFlowLayout.h"
#import "CustomIrregularGridViewCell.h"
@class IrregularGridViewCellClassType;
@class IrregularGridCollectionView;

@protocol IrregularGridCollectionViewDelegate <NSObject>

@optional

/**
 *  IrregularGridCollectionView did selected event.
 *
 *  @param collectionGridView CollectionGridView's object.
 *  @param cell               CustomCollectionGridViewCell type's cell.
 */
- (void)irregularGridCollectionView:(IrregularGridCollectionView *)irregularGridCollectionView
                    didSelectedCell:(CustomIrregularGridViewCell *)cell;

@end

@interface IrregularGridCollectionView : UIView

/**
 *  CollectionGridView's delegate.
 */
@property (nonatomic, weak) id <IrregularGridCollectionViewDelegate> delegate;

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
 *  Register the cells.
 */
@property (nonatomic, strong) NSArray <IrregularGridViewCellClassType *> *registerCells;

/**
 *  The cells data adapter.
 */
@property (nonatomic, strong) NSArray <IrregularGridCellDataAdapter *> *adapters;

/**
 *  To make the config effective.
 */
- (void)makeTheConfigEffective;

/**
 *  Get the CollectionView's content size.
 */
@property (nonatomic, readonly) CGSize contentSize;

/**
 *  Reset the view's size.
 */
- (void)resetSize;

@end

#pragma mark - CollectionGridViewCellClassType Class

@interface IrregularGridViewCellClassType : NSObject

@property (nonatomic)         Class      className;
@property (nonatomic, strong) NSString  *reuseIdentifier;

@end

NS_INLINE IrregularGridViewCellClassType *gridViewCellClassType(Class className, NSString  *reuseIdentifier) {
    
    IrregularGridViewCellClassType *type = [IrregularGridViewCellClassType new];
    type.className                        = className;
    type.reuseIdentifier                  = reuseIdentifier;
    
    return type;
}
