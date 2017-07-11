//
//  HorizontalCollectionItemViewCell.h
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/10.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "BaseCustomCollectionCell.h"
@class HorizontalCollectionItemView;

@interface HorizontalCollectionItemViewCell : BaseCustomCollectionCell

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier cellWidth:(CGFloat)width data:(id)data type:(NSInteger)type;
+ (CellDataAdapter *)dataAdapterWithData:(id)data cellWidth:(CGFloat)width type:(NSInteger)type;
+ (CellDataAdapter *)dataAdapterWithData:(id)data cellWidth:(CGFloat)width;

+ (void)registerToHorizontalCollectionItemView:(HorizontalCollectionItemView *)collectionView;
+ (void)registerToHorizontalCollectionItemView:(HorizontalCollectionItemView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier;

@end
