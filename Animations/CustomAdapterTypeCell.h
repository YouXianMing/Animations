//
//  CustomAdapterTypeCell.h
//  Animations
//
//  Created by YouXianMing on 15/11/27.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataAdapter.h"
@class CustomAdapterTypeCell;

@protocol CustomAdapterTypeCellDelegate <NSObject>

@optional

/**
 *  CustomCell's event.
 *
 *  @param cell  CustomAdapterTypeCell type class.
 *  @param event Event data.
 */
- (void)customAdapterTypeCell:(CustomAdapterTypeCell *)cell event:(id)event;

@end

@interface CustomAdapterTypeCell : UITableViewCell

#pragma mark - Propeties.

/**
 *  CustomCell's delegate.
 */
@property (nonatomic, weak) id <CustomAdapterTypeCellDelegate>  delegate;

/**
 *  CustomCell's data.
 */
@property (nonatomic, weak) CellDataAdapter         *dataAdapter;

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

#pragma mark - Useful method.

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
