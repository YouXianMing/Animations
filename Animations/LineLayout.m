//
//  LineLayout.m
//  UICollectionViewLayoutExample
//
//  Created by YouXianMing on 2017/7/13.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "LineLayout.h"

@interface LineLayout () {
    
    CGFloat  _itemWidth;
    CGFloat  _itemHeight;
    CGSize   _contentSize;
    
    NSArray <UICollectionViewLayoutAttributes *> *_attributes;
}

@end

@implementation LineLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    
    CGSize       collectionViewSize = self.collectionView.bounds.size;
    UIEdgeInsets contentInsets      = self.collectionView.contentInset;
    _itemWidth                      = collectionViewSize.width - (contentInsets.left + contentInsets.right);
    _itemHeight                     = collectionViewSize.height - (contentInsets.top + contentInsets.bottom);
    
    NSInteger       numberOfSections = [self.collectionView numberOfSections];
    CGFloat         offsetX          = 0;
    NSMutableArray *arrays           = [NSMutableArray array];
    
    for (int section = 0; section < numberOfSections; section++) {
        
        NSInteger numberOfRows = [self.collectionView numberOfItemsInSection:section];
        
        for (int row = 0; row < numberOfRows; row++) {
            
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
            attribute.frame                             = CGRectMake(offsetX, 0, _itemWidth, _itemHeight);
            offsetX                                    += _itemWidth;
            [arrays addObject:attribute];
        }
    }
    
    _contentSize = CGSizeMake(offsetX, _itemHeight);
    _attributes  = [arrays copy];
}

- (CGSize)collectionViewContentSize {
    
    return _contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *arrays = [NSMutableArray array];
    
    [_attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (CGRectIntersectsRect(obj.frame, rect)) {
            
            [arrays addObject:obj];
        }
    }];
    
    return arrays;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {

    UIEdgeInsets contentInsets = self.collectionView.contentInset;
    
    // 校正后的目的位移(偏移量从0开始,方便计算)
    CGFloat offsetX = proposedContentOffset.x + contentInsets.left;
    
    // 计算后的整数倍目标位移(四舍五入计算)
    CGFloat resultIntOffsetX = round(offsetX / _itemWidth) * _itemWidth - contentInsets.left;
    
    return CGPointMake(resultIntOffsetX, proposedContentOffset.y);
}

@end
