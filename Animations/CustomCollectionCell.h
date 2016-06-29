//
//  CustomCollectionCell.h
//  TechCode
//
//  Created by YouXianMing on 16/5/18.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataAdapter.h"
@class CustomCollectionCell;

@protocol CustomCollectionCellDelegate <NSObject>

@optional

/**
 *  CustomCollectionCell's event.
 *
 *  @param cell  CustomCollectionCell
 *  @param event Event.
 */
- (void)customCollectionCell:(CustomCollectionCell *)cell event:(id)event;

@end

@interface CustomCollectionCell : UICollectionViewCell

/**
 *  CustomCollectionCell's delegate.
 */
@property (nonatomic, weak) id <CustomCollectionCellDelegate> delegate;

/**
 *  CustomCell's data.
 */
@property (nonatomic, weak) CellDataAdapter         *dataAdapter;

/**
 *  CustomCell's data.
 */
@property (nonatomic, weak) id                       data;

/**
 *  CustomCell's indexPath.
 */
@property (nonatomic, weak) NSIndexPath             *indexPath;

/**
 *  TableView.
 */
@property (nonatomic, weak) UICollectionView        *collectionView;

/**
 *  Controller.
 */
@property (nonatomic, weak) UIViewController        *controller;

/**
 *  Cell is showed or not, you can set this property in UICollectionView's method 'collectionView:willDisplayCell:forItemAtIndexPath:' at runtime.
 */
@property (nonatomic)       BOOL                     display;

#pragma mark - Method you should overwrite.

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

#pragma mark - Useful method.

/**
 *  Selected event, override by subclass.
 */
- (void)selectedEvent;

/**
 *  Create the cell's dataAdapter.
 *
 *  @param reuseIdentifier Cell reuseIdentifier, can be nil.
 *  @param data            Cell's data, can be nil.
 *  @param height          Cell's height.
 *  @param type            Cell's type.
 *
 *  @return Cell's dataAdapter.
 */
+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                   data:(id)data
                                             cellHeight:(CGFloat)height
                                                   type:(NSInteger)type;

@end
