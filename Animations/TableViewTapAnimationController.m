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

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSArray       *dataArray;

@end

@implementation TableViewTapAnimationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)setup {
    
    [super setup];
    
    // Init dataArray.
    _dataArray = @[[TapAnimationModel modelWithName:@"YouXianMing" selected:YES],
                   [TapAnimationModel modelWithName:@"NoZuoNoDie" selected:NO],
                   [TapAnimationModel modelWithName:@"Animations" selected:NO]];
    
    // Init TableView.
    self.tableView                = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64)
                                                                 style:UITableViewStylePlain];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TableViewTapAnimationCell class] forCellReuseIdentifier:@"TableViewTapAnimationCell"];
    [self.view addSubview:self.tableView];
    
    [self bringTitleViewToFront];
}

#pragma mark - TableView相关方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewTapAnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewTapAnimationCell"];
    cell.data                       = _dataArray[indexPath.row];
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
    
    return 80.f;
}

@end
