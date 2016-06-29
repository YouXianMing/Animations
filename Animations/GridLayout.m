//
//  GridLayout.m
//  GridFlowLayoutExample
//
//  Created by YouXianMing on 16/5/4.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "GridLayout.h"

@interface GridLayout ()

@property (nonatomic, strong) NSMutableArray *attributesArray;

@end

@implementation GridLayout

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.attributesArray = [NSMutableArray array];
        self.manager         = [[GridManager alloc] init];
    }
    
    return self;
}

- (void)prepareLayout {

    [super prepareLayout];
    
    [self.manager reset];
    [self.manager prepare];

    NSInteger rowCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < rowCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.attributesArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // Get the item width.
    CGFloat itemWidth = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemWidthWithIndexPath:)]) {
        
        itemWidth = [self.delegate itemWidthWithIndexPath:indexPath];
    }
    
    // Get frame.
    [self.manager addElement:@(itemWidth)];
    attributes.frame = [self.manager frameByIndex:indexPath.row];
    
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *layoutAttribute = [NSMutableArray array];
    
    [self.attributesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UICollectionViewLayoutAttributes *attribute = obj;
        
        if (CGRectIntersectsRect(attribute.frame, rect)) {
            
            [layoutAttribute addObject:attribute];
        }
    }];
    
    return layoutAttribute;
}

- (CGSize)collectionViewContentSize {

    return [self.manager contentSize];
}

@end
