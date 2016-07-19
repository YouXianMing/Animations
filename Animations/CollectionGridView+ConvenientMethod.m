//
//  CollectionGridView+ConvenientMethod.m
//  Animations
//
//  Created by YouXianMing on 16/7/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CollectionGridView+ConvenientMethod.h"

@implementation CollectionGridView (ConvenientMethod)

+ (instancetype)collectionGridViewWithFixedWidth:(CGFloat)width
                               contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                                   horizontalGap:(CGFloat)horizontalGap
                                     verticalGap:(CGFloat)verticalGap
                                      gridHeight:(CGFloat)gridHeight
                             horizontalCellCount:(NSInteger)horizontalCellCount
                                   registerCells:(NSArray <CollectionGridViewCellClassType *> *)registerCells
                                        adapters:(NSArray <CollectionGridCellDataAdapter *> *)adapters
                                        delegate:(id <CollectionGridViewDelegate>)delegate {

    CollectionGridView *gridView = [[CollectionGridView alloc] initWithFrame:CGRectMake(0, 0, width, 10)];
    gridView.contentEdgeInsets   = contentEdgeInsets;
    gridView.horizontalGap       = horizontalGap;
    gridView.verticalGap         = verticalGap;
    gridView.gridHeight          = gridHeight;
    gridView.horizontalCellCount = horizontalCellCount;
    gridView.registerCells       = registerCells;
    gridView.adapters            = adapters;
    gridView.delegate            = delegate;
    [gridView reloadData];
    [gridView resetSize];
    
    return gridView;
}

@end
