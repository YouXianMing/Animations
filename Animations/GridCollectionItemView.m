//
//  GridCollectionItemView.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "GridCollectionItemView.h"

@implementation GridCollectionItemView

- (void)createLayout {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing     = 0.f;
    layout.sectionInset                = UIEdgeInsetsZero;
    layout.scrollDirection             = UICollectionViewScrollDirectionVertical;
    self.layout                        = layout;
}

- (void)setup {
    
    self.itemHeight          = 20.f;
    self.horizontalCellCount = 3;
}

- (void)resetSize {
    
    NSParameterAssert(self.gridCollectionItemViewWidth > 0);
    NSParameterAssert(self.horizontalCellCount > 0);
    NSParameterAssert(self.itemHeight > 0);
    
    // Set the collectionView's bounds.
    self.collectionView.bounds = CGRectMake(0, 0, self.gridCollectionItemViewWidth, MAXFLOAT);
    
    // Get the item width.
    CGFloat itemWidth = (self.gridCollectionItemViewWidth - (self.horizontalCellCount - 1) * self.horizontalItemSpace - (_contentEdge.left + _contentEdge.right)) / self.horizontalCellCount;
    
    // Set the itemSize.
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.layout;
    layout.itemSize                    = CGSizeMake(itemWidth, self.itemHeight);
    
    // Reset the GridCollectionItemView's bounds.
    CGSize size = self.layout.collectionViewContentSize;
    self.frame  = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

+ (instancetype)gridCollectionItemViewWithCollectionItemViewWidth:(CGFloat)gridCollectionItemViewWidth
                                                         delegate:(id <CustomCollectionViewDelegate>)delegate
                                                verticalItemSpace:(CGFloat)verticalItemSpace
                                              horizontalItemSpace:(CGFloat)horizontalItemSpace
                                                       itemHeight:(CGFloat)itemHeight
                                                      contentEdge:(UIEdgeInsets)contentEdge
                                              horizontalCellCount:(NSUInteger)horizontalCellCount {
    
    GridCollectionItemView *itemView     = [[GridCollectionItemView alloc] init];
    itemView.gridCollectionItemViewWidth = gridCollectionItemViewWidth;
    itemView.delegate                    = delegate;
    itemView.verticalItemSpace           = verticalItemSpace;
    itemView.horizontalItemSpace         = horizontalItemSpace;
    itemView.itemHeight                  = itemHeight;
    itemView.contentEdge                 = contentEdge;
    itemView.horizontalCellCount         = horizontalCellCount;
    
    return itemView;
}

+ (instancetype)gridCollectionItemViewWithCollectionItemViewWidth:(CGFloat)gridCollectionItemViewWidth
                                                         delegate:(id <CustomCollectionViewDelegate>)delegate
                                                verticalItemSpace:(CGFloat)verticalItemSpace
                                              horizontalItemSpace:(CGFloat)horizontalItemSpace
                                                       itemHeight:(CGFloat)itemHeight
                                                      contentEdge:(UIEdgeInsets)contentEdge
                                              horizontalCellCount:(NSUInteger)horizontalCellCount
                                                    registerCells:(void (^)(CustomCollectionView *customCollectionView))registerCellsBlock
                                                      addAdapters:(void (^)(NSMutableArray <CellDataAdapter *> *adapters))addAdaptersBlock {
    
    GridCollectionItemView *itemView     = [[GridCollectionItemView alloc] init];
    itemView.gridCollectionItemViewWidth = gridCollectionItemViewWidth;
    itemView.delegate                    = delegate;
    itemView.verticalItemSpace           = verticalItemSpace;
    itemView.horizontalItemSpace         = horizontalItemSpace;
    itemView.itemHeight                  = itemHeight;
    itemView.contentEdge                 = contentEdge;
    itemView.horizontalCellCount         = horizontalCellCount;
    
    registerCellsBlock ? registerCellsBlock((CustomCollectionView *)itemView) : 0;
    addAdaptersBlock   ? addAdaptersBlock(itemView.adapters) : 0;
    
    [itemView reloadData];
    [itemView resetSize];
    
    return itemView;
}

#pragma mark - Setter

- (void)setVerticalItemSpace:(CGFloat)verticalItemSpace {

    _verticalItemSpace = verticalItemSpace;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.layout;
    layout.minimumLineSpacing = verticalItemSpace;
}

- (void)setHorizontalItemSpace:(CGFloat)horizontalItemSpace {
    
    _horizontalItemSpace = horizontalItemSpace;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.layout;
    layout.minimumInteritemSpacing = horizontalItemSpace;
}

- (void)setContentEdge:(UIEdgeInsets)contentEdge {
    
    _contentEdge = contentEdge;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.layout;
    layout.sectionInset = contentEdge;
}

@end
