//
//  NormalTitleTableViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/7/31.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "NormalTitleTableViewController.h"

@interface NormalTitleTableViewController ()

@end

@implementation NormalTitleTableViewController

#pragma mark - Overwrite super method.

- (void)setupDataSource {
    
    self.adapters = [NSMutableArray array];
}

- (void)setupSubViews {
    
    [super setupSubViews];
    
    // Init tableView.
    self.tableView                = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.tableView];
    
    // Register cells
    [self registerCellsWithTableView:self.tableView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.adapters[indexPath.row];
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter = adapter;
    cell.data        = adapter.data;
    cell.tableView   = tableView;
    cell.indexPath   = indexPath;
    cell.delegate    = self;
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectedEvent];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.adapters[indexPath.row].cellHeight;
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    
}

#pragma mark - Overwrite by subClass

- (void)registerCellsWithTableView:(UITableView *)tableView {
    
}

@end
