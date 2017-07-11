//
//  HorizontalCollectionItemViewCell.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/10.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "HorizontalCollectionItemViewCell.h"
#import "HorizontalCollectionItemView.h"

@implementation HorizontalCollectionItemViewCell

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier cellWidth:(CGFloat)width data:(id)data type:(NSInteger)type {
    
    NSString        *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    CellDataAdapter *adapter            = [CellDataAdapter collectionCellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellType:type];
    adapter.cellWidth                   = width;
    
    return adapter;
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data cellWidth:(CGFloat)width type:(NSInteger)type {
    
    CellDataAdapter *adapter            = [CellDataAdapter collectionCellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:data cellType:type];
    adapter.cellWidth                   = width;
    
    return adapter;
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data cellWidth:(CGFloat)width {
    
    CellDataAdapter *adapter            = [CellDataAdapter collectionCellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:data cellType:0];
    adapter.cellWidth                   = width;
    
    return adapter;
}

+ (void)registerToHorizontalCollectionItemView:(HorizontalCollectionItemView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier {
    
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:reuseIdentifier.length ? reuseIdentifier : NSStringFromClass([self class])];
}

+ (void)registerToHorizontalCollectionItemView:(HorizontalCollectionItemView *)collectionView {
    
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
}

@end
