//
//  ComplexLineLayout.m
//  UICollectionViewLayoutExample
//
//  Created by YouXianMing on 2017/7/18.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ComplexLineLayout.h"
#import "Math.h"

@interface ComplexLineLayout () {
    
    CGFloat  _itemWidth;
    CGFloat  _itemHeight;
    CGSize   _contentSize;
    
    NSArray <UICollectionViewLayoutAttributes *> *_attributes;
    
    Math *_math;
}

@end

@implementation ComplexLineLayout

- (instancetype)init {
    
    if (self = [super init]) {
        
        _math = [Math mathOnceLinearEquationWithPointA:MATHPointMake(0.25f, 1.f) PointB:MATHPointMake(1.f, 0.8f)];
    }
    
    return self;
}

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
    
    // 换算后的collectionView的中心点
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.contentInset.left + _itemWidth / 2.f;
    
    // 只对有效点进行计算
    [arrays enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 查看row为2的item的中心点百分比
        if (obj.indexPath.row == 2 && obj.indexPath.section == 0) {
            
            NSLog(@"%f", (centerX - obj.center.x) / _itemWidth);
        }
        
        // 每个布局的中心点与换算后的collectionView的中心点的差值除以布局元素的宽度换算成的百分比绝对值
        CGFloat centerOffset = ABS((centerX - obj.center.x) / _itemWidth);
        
        CGFloat scaleValue = 0;
        if (centerOffset <= 0.25f) {
            
            scaleValue = 1.f;
            
        } else if (centerOffset <= 1.f) {
            
            scaleValue = _math.k * centerOffset + _math.b;
            
        } else {
            
            scaleValue = 0.8f;
        }
        
        obj.transform = CGAffineTransformMakeScale(scaleValue, scaleValue);
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
