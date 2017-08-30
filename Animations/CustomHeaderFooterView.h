//
//  CustomHeaderFooterView.h
//  Animations
//
//  Created by YouXianMing on 15/11/30.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellHeaderFooterDataAdapter.h"
@class CustomHeaderFooterView;

@protocol CustomHeaderFooterViewDelegate <NSObject>

@optional

/**
 *  CustomHeaderFooterView's event.
 *
 *  @param customHeaderFooterView CustomHeaderFooterView object.
 *  @param event                  Event data.
 */
- (void)customHeaderFooterView:(CustomHeaderFooterView *)customHeaderFooterView event:(id)event;

@end

@interface CustomHeaderFooterView : UITableViewHeaderFooterView

#pragma mark - Propeties.

/**
 *  CustomHeaderFooterView's delegate.
 */
@property (nonatomic, weak) id <CustomHeaderFooterViewDelegate> delegate;

/**
 *  CustomHeaderFooterView's dataAdapter.
 */
@property (nonatomic, weak) CellHeaderFooterDataAdapter *dataAdapter;

/**
 *  CustomHeaderFooterView's data.
 */
@property (nonatomic, weak) id data;

/**
 *  UITableView's section.
 */
@property (nonatomic) NSInteger section;

/**
 *  TableView.
 */
@property (nonatomic, weak) UITableView *tableView;

/**
 *  Controller.
 */
@property (nonatomic, weak) UIViewController *controller;

#pragma mark - Some useful method.

/**
 *  Set HeaderFooterView backgroundColor.
 *
 *  @param color Color.
 */
- (void)setHeaderFooterViewBackgroundColor:(UIColor *)color;

/**
 *  Register to tableView with the reuseIdentifier you specified.
 *
 *  @param tableView       TableView.
 *  @param reuseIdentifier The cell reuseIdentifier.
 */
+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

/**
 *  Register to tableView with the The class name.
 *
 *  @param tableView       TableView.
 */
+ (void)registerToTableView:(UITableView *)tableView;

#pragma mark - Method override by subclass.

/**
 *  Setup HeaderFooterView, override by subclass.
 */
- (void)setupHeaderFooterView;

/**
 *  Build subview, override by subclass.
 */
- (void)buildSubview;

/**
 *  Load content, override by subclass.
 */
- (void)loadContent;

/**
 *  Calculate the cell's from data, overwrite by subclass.
 *
 *  @param data Data.
 *
 *  @return HeaderFooterView's height.
 */
+ (CGFloat)heightWithData:(id)data;

#pragma mark - Adapters.

+ (CellHeaderFooterDataAdapter *)dataAdapterWithReuseIdentifier:(NSString *)reuseIdentifier data:(id)data height:(CGFloat)height type:(NSInteger)type;
+ (CellHeaderFooterDataAdapter *)dataAdapterWithData:(id)data height:(CGFloat)height type:(NSInteger)type;
+ (CellHeaderFooterDataAdapter *)dataAdapterWithData:(id)data height:(CGFloat)height;
+ (CellHeaderFooterDataAdapter *)dataAdapterWithHeight:(CGFloat)height type:(NSInteger)type;
+ (CellHeaderFooterDataAdapter *)dataAdapterWithHeight:(CGFloat)height;

+ (CellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type;
+ (CellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data type:(NSInteger)type;
+ (CellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data;
+ (CellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapter;

@end
