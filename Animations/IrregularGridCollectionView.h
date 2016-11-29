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
 *  @param event              CustomCollectionGridViewCell's event.
 */
- (void)irregularGridCollectionView:(IrregularGridCollectionView *)irregularGridCollectionView didSelectedCell:(CustomIrregularGridViewCell *)cell event:(id)event;

@end

@interface IrregularGridCollectionView : UIView

/**
 *  CollectionGridView's delegate.
 */
@property (nonatomic, weak) id <IrregularGridCollectionViewDelegate> delegate;

/**
 *  CollectionView.
 */
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

/**
 *  The scroll direction of the grid, default is UICollectionViewScrollDirectionVertical.
 */
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

/**
 *  Content edgeInsets, default is UIEdgeInsetsMake(5, 5, 5, 5).
 */
@property (nonatomic) UIEdgeInsets contentEdgeInsets;

/**
 *  Item's interitemSpacing, default is 5.f.
 */
@property (nonatomic) CGFloat interitemSpacing;

/**
 *  Item's lineSpacing, default is 5.f.
 */
@property (nonatomic) CGFloat lineSpacing;

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
@property (nonatomic, strong) NSMutableArray <IrregularGridCellDataAdapter *> *adapters;

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

#pragma mark - Constructor.

+ (instancetype)irregularGridCollectionViewWithFrame:(CGRect)frame
                                            delegate:(id <IrregularGridCollectionViewDelegate>)delegate
                                       registerCells:(NSArray <IrregularGridViewCellClassType *> *)registerCells
                                     scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                                   contentEdgeInsets:(UIEdgeInsets)edgeInsets
                                         lineSpacing:(CGFloat)lineSpacing
                                    interitemSpacing:(CGFloat)interitemSpacing
                                          gridHeight:(CGFloat)gridHeight;

@end

#pragma mark - CollectionGridViewCellClassType Class

@interface IrregularGridViewCellClassType : NSObject

@property (nonatomic)         Class      className;
@property (nonatomic, strong) NSString  *reuseIdentifier;

@end

NS_INLINE IrregularGridViewCellClassType *gridViewCellClassType(Class className, NSString  *reuseIdentifier) {
    
    IrregularGridViewCellClassType *type = [IrregularGridViewCellClassType new];
    type.className                        = className;
    type.reuseIdentifier                  = reuseIdentifier.length ? reuseIdentifier : NSStringFromClass(className);
    
    return type;
}
