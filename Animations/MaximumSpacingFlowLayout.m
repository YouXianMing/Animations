//
//  MaximumSpacingFlowLayout.m
//  IrregularGridCollectionView
//
//  Created by YouXianMing on 16/8/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "MaximumSpacingFlowLayout.h"
#import "CellAttributesManager.h"

@implementation MaximumSpacingFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        
        // 将同一行的cell进行分组
        CellAttributesManager *manager = [CellAttributesManager new];
        [layoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attributes, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [manager buildAnAttributesArray];
                [manager addAttributes:attributes];
                
            } else {
                
                if (manager.attributesArray.lastObject.lastObject.center.y == attributes.center.y) {
                    
                    [manager addAttributes:attributes];
                    
                } else {
                    
                    [manager buildAnAttributesArray];
                    [manager addAttributes:attributes];
                }
            }
        }];
        
        // 对每一行的cell进行位置的调整
        [manager.attributesArray enumerateObjectsUsingBlock:^(NSMutableArray<UICollectionViewLayoutAttributes *> * _Nonnull array, NSUInteger idx, BOOL * _Nonnull stop) {
            
            __block CGFloat offsetX = 0.f;
            
            if (self.collectionView.semanticContentAttribute == UISemanticContentAttributeForceRightToLeft) {
                
                [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        offsetX = obj.frame.origin.x - self.minimumInteritemSpacing;
                        
                    } else {
                        
                        obj.frame = CGRectMake(offsetX - obj.frame.size.width, obj.frame.origin.y, obj.frame.size.width, obj.frame.size.height);
                        offsetX   = obj.frame.origin.x - self.minimumInteritemSpacing;
                    }
                }];
                
            } else {
                
                [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        offsetX = obj.frame.origin.x + obj.frame.size.width + self.minimumInteritemSpacing;
                        
                    } else {
                        
                        obj.frame = CGRectMake(offsetX, obj.frame.origin.y, obj.frame.size.width, obj.frame.size.height);
                        offsetX   = obj.frame.origin.x + obj.frame.size.width + self.minimumInteritemSpacing;
                    }
                }];
            }
        }];
    }
    
    return layoutAttributes;
}

@end
