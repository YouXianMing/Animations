//
//  CustomCollectionView.h
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomCollectionCell.h"
@class CustomCollectionView;

@protocol CustomCollectionViewDelegate <NSObject>

@optional

/**
 CustomCollectionView did select cell.
 
 @param customCollectionView The CustomCollectionView.
 @param cell The BaseCustomCollectionCell's cell.
 @param indexPath The indexPath.
 */
- (void)customCollectionView:(CustomCollectionView *)customCollectionView didSelectCell:(BaseCustomCollectionCell *)cell indexPath:(NSIndexPath *)indexPath;

/**
 The customCollectionView's cell event.
 
 [IMPORMANT] The cell must call it's delegate's methods '- (void)customCollectionCell:(BaseCustomCollectionCell *)cell event:(id)event;' to make this active.
 
 @param customCollectionView The CustomCollectionView.
 @param cell The BaseCustomCollectionCell's cell.
 @param event The cell's event.
 */
- (void)customCollectionView:(CustomCollectionView *)customCollectionView cell:(BaseCustomCollectionCell *)cell event:(id)event;

@end

@interface CustomCollectionView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, CustomCollectionCellDelegate>

/**
 The custom collectionView's delegate.
 */
@property (nonatomic, weak) id <CustomCollectionViewDelegate> delegate;

/**
 The collectionView.
 */
@property (nonatomic, strong) UICollectionView  *collectionView;

/**
 The collectionView's layout.
 */
@property (nonatomic, strong) UICollectionViewLayout *layout;

/**
 The cell's data adapters.
 */
@property (nonatomic) NSMutableArray <CellDataAdapter *> *adapters;

/**
 Register cell's class with reuseIdentifier.
 
 @param cellClass HorizontalCollectionItemViewCell's subclass.
 @param reuseIdentifier The reuseIdentifier.
 */
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)reuseIdentifier;

/**
 Register cell's class with the class's name.
 
 @param cellClass HorizontalCollectionItemViewCell's subclass.
 */
- (void)registerClass:(Class)cellClass;

/**
 Reload the data.
 */
- (void)reloadData;

/**
 Animates multiple insert, delete, reload, and move operations as a group.
 
 @param editAdaptersBlock Edit the dataSource.
 @param editItemsBlock Edit the indexPaths.
 @param completionBlock Completion callback.
 */
- (void)editCustomCollectionViewAdapters:(void (^)(NSMutableArray <CellDataAdapter *> *adapters))editAdaptersBlock
                   editItemsAtIndexPaths:(void (^)(UICollectionView  *collectionView))editItemsBlock
                              completion:(void (^)(BOOL finished))completionBlock;

#pragma mark - Overwrite by sub class

/**
 [- Overwrite by sub class -] Create the layout.
 */
- (void)createLayout;

/**
 [- Overwrite by sub class -] setup.
 */
- (void)setup;

@end
