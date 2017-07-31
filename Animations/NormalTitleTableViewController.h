//
//  NormalTitleTableViewController.h
//  Animations
//
//  Created by YouXianMing on 2017/7/31.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "NormalTitleController.h"
#import "CustomCell.h"

@interface NormalTitleTableViewController : NormalTitleController <UITableViewDelegate, UITableViewDataSource, CustomCellDelegate>

@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

- (void)customCell:(CustomCell *)cell event:(id)event;
- (void)registerCellsWithTableView:(UITableView *)tableView;

@end
