//
//  TwoLevelLinkageView.h
//  SecondList
//
//  Created by YouXianMing on 2017/8/25.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLevelLinkageCell.h"
#import "CustomHeaderFooterView.h"
#import "LinkageOneLevelModel.h"
@class TwoLevelLinkageView;

@protocol TwoLevelLinkageViewDelegate <NSObject>

@optional

- (void)twoLevelLinkageView:(TwoLevelLinkageView *)linkageView selectedLeftSideTableViewItemRow:(NSInteger)row item:(id)data;
- (void)twoLevelLinkageView:(TwoLevelLinkageView *)linkageView selectedRightSideTableViewItemIndexPath:(NSIndexPath *)indexPath
                       item:(id)data;

@end

@interface TwoLevelLinkageView : UIView

@property (nonatomic, strong) NSArray <LinkageOneLevelModel *> *models;
@property (nonatomic, weak) id <TwoLevelLinkageViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame leftSideWidth:(CGFloat)leftSideWidth;

- (void)leftTableViewCellMakeSelectedAtRow:(NSInteger)row;
- (void)reloadData;
- (void)registerCellsWithLeftSideTableView:(void (^)(UITableView *tableView))leftSideTableViewBlock registerCellsAndHeadersWithRightSideTableView:(void (^)(UITableView *tableView))rightSideTableViewBlock;

@end
