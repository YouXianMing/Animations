//
//  CollectionGridView+ConvenientMethod.h
//  Animations
//
//  Created by YouXianMing on 16/7/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CollectionGridView.h"

@interface CollectionGridView (ConvenientMethod)

/**
 *  Create CollectionGridView.
 *
 *  @param width               The fixed width.
 *  @param contentEdgeInsets   Content edgeInsets.
 *  @param horizontalGap       horizontal gap.
 *  @param verticalGap         Vertical gap.
 *  @param gridHeight          Grid height.
 *  @param horizontalCellCount Horizontal cell's count.
 *  @param registerCells       Register cells.
 *  @param adapters            Adapters.
 *  @param delegate            CollectionGridView's delegate.
 *
 *  @return CollectionGridView.
 */
+ (instancetype)collectionGridViewWithFixedWidth:(CGFloat)width
                               contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                                   horizontalGap:(CGFloat)horizontalGap
                                     verticalGap:(CGFloat)verticalGap
                                      gridHeight:(CGFloat)gridHeight
                             horizontalCellCount:(NSInteger)horizontalCellCount
                                   registerCells:(NSArray <CollectionGridViewCellClassType *> *)registerCells
                                        adapters:(NSArray <CollectionGridCellDataAdapter *> *)adapters
                                        delegate:(id <CollectionGridViewDelegate>)delegate;

@end
