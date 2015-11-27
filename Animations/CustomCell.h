//
//  CustomCell.h
//  Animations
//
//  Created by YouXianMing on 15/11/27.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
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
 *  CustomCell's data.
 */
@property (nonatomic, weak) id                       data;

/**
 *  CustomCell's indexPath.
 */
@property (nonatomic, weak) NSIndexPath             *indexPath;

/**
 *  TableView from out.
 */
@property (nonatomic, weak) UITableView             *tableView;

/**
 *  Controller from out.
 */
@property (nonatomic, weak) UIViewController        *controller;

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
