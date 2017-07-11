//
//  HorizontalCollectionItemView.h
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/10.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CustomCollectionView.h"

@interface HorizontalCollectionItemView : CustomCollectionView

/**
 Item's space, default is 0.
 */
@property (nonatomic) CGFloat itemSpace;

/**
 Content's edge, default is 
 */
@property (nonatomic) UIEdgeInsets contentEdge;

#pragma mark - Constructors

+ (instancetype)horizontalCollectionItemViewWithFrame:(CGRect)frame
                                            ItemSpace:(CGFloat)itemSpace
                                          contentEdge:(UIEdgeInsets)contentEdge;

+ (instancetype)horizontalCollectionItemViewWithFrame:(CGRect)frame
                                            ItemSpace:(CGFloat)itemSpace
                                          contentEdge:(UIEdgeInsets)contentEdge
                                             delegate:(id <CustomCollectionViewDelegate>)delegate
                                        registerCells:(void (^)(HorizontalCollectionItemView *collectionView))registerCellsBlock
                                          addAdapters:(void (^)(NSMutableArray <CellDataAdapter *> *adapters))addAdaptersBlock;

@end
