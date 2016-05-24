//
//  GridCollectionView.h
//  UICollectionView
//
//  Created by YouXianMing on 16/5/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridCollectionViewCell.h"
@class GridCollectionView;

@protocol GridCollectionViewDelegate <NSObject>

@optional

- (void)gridCollectionView:(GridCollectionView *)view
               didSelected:(GridCollectionViewCell *)cell
                 indexPath:(NSIndexPath *)indexPath;

@end

@interface GridCollectionView : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id <GridCollectionViewDelegate>  delegate;

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
 *  获取contentSize
 *
 *  @return contentSize
 */
- (CGSize)contentSize;

/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray  *datas;

#pragma mark - ReadOnly Properties.

@property (nonatomic, strong, readonly) UICollectionViewFlowLayout  *flowLayout;
@property (nonatomic, strong, readonly) UICollectionView            *collectionView;

@end
