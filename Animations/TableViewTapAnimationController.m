//
//  TableViewTapAnimationController.m
//  Animations
//
//  Created by YouXianMing on 15/11/27.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "TableViewTapAnimationController.h"
#import "TableViewTapAnimationCell.h"
#import "UIView+SetRect.h"
#import "TapAnimationModel.h"

@interface TableViewTapAnimationController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray  *dataArray;

@end

@implementation TableViewTapAnimationController

- (void)setup {
    
    [super setup];
    
    // Init dataArray.
    self.dataArray = [NSMutableArray array];
    NSArray *array = @[[TapAnimationModel modelWithName:@"YouXianMing" selected:YES],
                       [TapAnimationModel modelWithName:@"NoZuoNoDie" selected:NO],
                       [TapAnimationModel modelWithName:@"Animations" selected:NO]];
    
    for (int i = 0; i < array.count; i++) {
        
        CellDataAdapter *dataAdapter = [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"TableViewTapAnimationCell"
                                                                                          data:array[i]
                                                                                    cellHeight:80
                                                                                      cellType:0];
        [self.dataArray addObject:dataAdapter];
    }
    
    // Init TableView.
    self.tableView                = [[UITableView alloc] initWithFrame:self.contentView.bounds
                                                                 style:UITableViewStylePlain];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TableViewTapAnimationCell class] forCellReuseIdentifier:@"TableViewTapAnimationCell"];
    [self.contentView addSubview:self.tableView];
}

#pragma mark - TableView相关方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *dataAdapter = _dataArray[indexPath.row];
    
    TableViewTapAnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:dataAdapter.cellReuseIdentifier];
    cell.dataAdapter                = dataAdapter;
    [cell loadContent];
    [cell changeStateAnimated:NO];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewTapAnimationCell *cell = (TableViewTapAnimationCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell showSelectedAnimation];
    [cell changeStateAnimated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *dataAdapter = _dataArray[indexPath.row];
    
    return dataAdapter.cellHeight;
}

@end
