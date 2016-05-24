//
//  GridCollectionView.h
//  UICollectionView
//
//  Created by YouXianMing on 16/5/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridCollectionViewCell.h"

@interface GridCollectionView : UIView

/**
 *  Cell的尺寸
 */
@property (nonatomic) CGSize itemSize;

/**
 *  UICollectionView滑动的方向
 */
@property (nonatomic) UICollectionViewScrollDirection  scrollDirection;

/**
 *  配置cell的模板
 *
 *  @param cell cell对象
 */
- (void)configCellPattern:(GridCollectionViewCell *)cell;

/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray  *datas;

#pragma mark - ReadOnly Properties.

@property (nonatomic, strong, readonly) UICollectionViewFlowLayout  *flowLayout;
@property (nonatomic, strong, readonly) UICollectionView            *collectionView;

@end
