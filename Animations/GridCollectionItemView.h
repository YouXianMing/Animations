//
//  GridCollectionItemView.h
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CustomCollectionView.h"

@interface GridCollectionItemView : CustomCollectionView

/**
 The GridCollectionItemView's width, you must set this value before you call the 'resetSize' method.
 */
@property (nonatomic) CGFloat gridCollectionItemViewWidth;

/**
 Vertical direction item's space, default is 0.
 */
@property (nonatomic) CGFloat verticalItemSpace;

/**
 Horizontal direction item's space, default is 0.
 */
@property (nonatomic) CGFloat horizontalItemSpace;

/**
 *  Item's height, default is 20.f.
 */
@property (nonatomic) CGFloat itemHeight;

/**
 Content's edge, default is UIEdgeInsetsZero.
 */
@property (nonatomic) UIEdgeInsets contentEdge;

/**
 *  The cell's count at the horizontal direction, default is 3.
 */
@property (nonatomic) NSUInteger horizontalCellCount;

/**
 After you set all the properties, set the adapters, you must call this method to reset GridCollectionItemView's frame.
 */
- (void)resetSize;

#pragma mark - Constructors

+ (instancetype)gridCollectionItemViewWithCollectionItemViewWidth:(CGFloat)gridCollectionItemViewWidth
                                                         delegate:(id <CustomCollectionViewDelegate>)delegate
                                                verticalItemSpace:(CGFloat)verticalItemSpace
                                              horizontalItemSpace:(CGFloat)horizontalItemSpace
                                                       itemHeight:(CGFloat)itemHeight
                                                      contentEdge:(UIEdgeInsets)contentEdge
                                              horizontalCellCount:(NSUInteger)horizontalCellCount;

+ (instancetype)gridCollectionItemViewWithCollectionItemViewWidth:(CGFloat)gridCollectionItemViewWidth
                                                         delegate:(id <CustomCollectionViewDelegate>)delegate
                                                verticalItemSpace:(CGFloat)verticalItemSpace
                                              horizontalItemSpace:(CGFloat)horizontalItemSpace
                                                       itemHeight:(CGFloat)itemHeight
                                                      contentEdge:(UIEdgeInsets)contentEdge
                                              horizontalCellCount:(NSUInteger)horizontalCellCount
                                                    registerCells:(void (^)(CustomCollectionView *customCollectionView))registerCellsBlock
                                                      addAdapters:(void (^)(NSMutableArray <CellDataAdapter *> *adapters))addAdaptersBlock;
@end
