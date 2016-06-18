//
//  CustomCell.h
//  Animations
//
//  Created by YouXianMing on 16/1/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataAdapter.h"
@class CustomCell;

@protocol CustomCellDelegate <NSObject>

@optional

/**
 *  CustomCell's event.
 *
 *  @param cell  CustomCell type class.
 *  @param event Event data.
 */
- (void)customCell:(CustomCell *)cell event:(id)event;

@end

@interface CustomCell : UITableViewCell

#pragma mark - Propeties.

/**
 *  CustomCell's delegate.
 */
@property (nonatomic, weak) id <CustomCellDelegate>  delegate;

/**
 *  CustomCell's dataAdapter.
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
@property (nonatomic, weak) UITableView             *tableView;

/**
 *  Controller.
 */
@property (nonatomic, weak) UIViewController        *controller;

/**
 *  Cell is showed or not, you can set this property in UITableView's method 'tableView:willDisplayCell:forRowAtIndexPath:' & 'tableView:didEndDisplayingCell:forRowAtIndexPath:' at runtime.
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
 *  Create the cell's dataAdapter.
 *
 *  @param reuseIdentifier Cell reuseIdentifier, can be nil.
 *  @param data            Cell's data, can be nil.
 *  @param height          Cell's height.
 *  @param type            Cell's type.
 *
 *  @return Cell's dataAdapter.
 */
+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data
                                             cellHeight:(CGFloat)height type:(NSInteger)type;

/**
 *  Convenient method to set some weak reference.
 *
 *  @param dataAdapter CellDataAdapter's object.
 *  @param data        Data.
 *  @param indexPath   IndexPath.
 *  @param tableView   TableView.
 */
- (void)setWeakReferenceWithCellDataAdapter:(CellDataAdapter *)dataAdapter data:(id)data
                                  indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

/**
 *  Selected event, you should use this method in 'tableView:didSelectRowAtIndexPath:' to make it effective.
 */
- (void)selectedEvent;

/**
 *  Update the cell's height with animated or not, before you use this method, you should have the weak reference 'tableView' and 'dataAdapter', and this method will update the weak reference dataAdapter's property cellHeight.
 *
 *  @param height   The new cell height.
 *  @param animated Animated or not.
 */
- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated;

@end
