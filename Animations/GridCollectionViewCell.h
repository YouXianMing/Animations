//
//  GridCollectionViewCell.h
//  UICollectionView
//
//  Created by YouXianMing on 16/5/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridCollectionViewCell : UICollectionViewCell

@property (nonatomic, readonly)  CGFloat      width;
@property (nonatomic, readonly)  CGFloat      height;
@property (nonatomic, strong)    NSIndexPath *indexPath;
@property (nonatomic, strong)    id           data;

- (void)setupCell;
- (void)buildSubViews;
- (void)loadContent;

@end
