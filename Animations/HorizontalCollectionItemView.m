//
//  HorizontalCollectionItemView.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/10.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "HorizontalCollectionItemView.h"

@interface HorizontalCollectionItemView () <UICollectionViewDelegateFlowLayout> {
    
    CGFloat _itemHeight;
}

@end

@implementation HorizontalCollectionItemView

- (void)createLayout {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing     = 0.f;
    layout.sectionInset                = UIEdgeInsetsZero;
    layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
    self.layout                        = layout;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.adapters[indexPath.row].cellWidth, _itemHeight);
}

#pragma mark - Overwrite system method.

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _itemHeight = self.collectionView.bounds.size.height - self.contentEdge.top - self.contentEdge.bottom;
}

#pragma mark - Setter

- (void)setItemSpace:(CGFloat)itemSpace {
    
    _itemSpace = itemSpace;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.layout;
    layout.minimumInteritemSpacing = itemSpace;
}

- (void)setContentEdge:(UIEdgeInsets)contentEdge {
    
    _contentEdge = contentEdge;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.layout;
    layout.sectionInset = contentEdge;
}

@end
