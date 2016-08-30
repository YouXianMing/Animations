//
//  MaximumSpacingFlowLayout.m
//  IrregularGridCollectionView
//
//  Created by YouXianMing on 16/8/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "MaximumSpacingFlowLayout.h"

@implementation MaximumSpacingFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *original = [super layoutAttributesForElementsInRect:rect];
    NSArray *answer   = [[NSArray alloc] initWithArray:original copyItems:YES];
    
    for(int i = 1; i < [answer count]; ++i) {
        
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes    = answer[i - 1];
        
        NSInteger maximumSpacing = self.minimumInteritemSpacing;
        NSInteger origin         = CGRectGetMaxX(prevLayoutAttributes.frame);
        
        if (origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            
            CGRect frame   = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    
    return answer;
}

@end
