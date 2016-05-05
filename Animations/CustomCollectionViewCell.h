//
//  CustomCollectionViewCell.h
//  LayoutViewController
//
//  Created by YouXianMing on 16/5/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell

/**
 *  CustomCell's data.
 */
@property (nonatomic, weak) id                data;

/**
 *  CustomCell's indexPath.
 */
@property (nonatomic, weak) NSIndexPath      *indexPath;

/**
 *  The collectionView.
 */
@property (nonatomic, weak) UICollectionView *collectionView;

/**
 *  Setup cell, override by subclass.
 */
- (void)setupCell;

/**
 *  Build subview, override by subclass.
 */
- (void)buildSubview;

/**
 *  Load content, override by subclass.
 */
- (void)loadContent;

@end
