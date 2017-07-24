//
//  TreeStructureTableViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/7/24.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "TreeStructureTableViewController.h"
#import "CityModel.h"
#import "CityModelCell.h"

@interface TreeStructureTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView                  *tableView;
@property (nonatomic, strong) NSMutableArray <CityModel *> *datas;

@end

@implementation TreeStructureTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Tree type data.
    NSArray *treeDatas = @[@{@"text":@"河北省",
                             @"level":@"0",
                             @"submodels":@[@{@"text":@"衡水市",
                                              @"level":@"1",
                                              @"submodels":@[@{@"text":@"阜城县",
                                                               @"level":@"2",
                                                               @"submodels":@[@{@"text":@"大白乡",
                                                                                @"level":@"3",},
                                                                              @{@"text":@"建桥乡",
                                                                                @"level":@"3",},
                                                                              @{@"text":@"古城镇",
                                                                                @"level":@"3",}]},
                                                             @{@"text":@"武邑县",
                                                               @"level":@"2",},
                                                             @{@"text":@"景县",
                                                               @"level":@"2",}]},
                                            @{@"text":@"廊坊市",
                                              @"level":@"1",
                                              @"submodels":@[@{@"text":@"固安县",
                                                               @"level":@"2",},
                                                             @{@"text":@"三河市",
                                                               @"level":@"2",},
                                                             @{@"text":@"霸州市",
                                                               @"level":@"2",}]}]},
                           @{@"text":@"山东省",
                             @"level":@"0",
                             @"submodels":@[@{@"text":@"德州市",
                                              @"level":@"1",
                                              @"submodels":@[@{
                                                                 @"text":@"临邑县",
                                                                 @"level":@"2",},
                                                             @{@"text":@"齐河县",
                                                               @"level":@"2",},
                                                             @{@"text":@"平原县",
                                                               @"level":@"2",}]},
                                            @{@"text":@"烟台市",
                                              @"level":@"1",
                                              @"submodels":@[@{
                                                                 @"text":@"蓬莱市",
                                                                 @"level":@"2",},
                                                             @{@"text":@"招远市",
                                                               @"level":@"2",},
                                                             @{@"text":@"海阳市",
                                                               @"level":@"2",}]}]},];
    
    // DataSource.
    self.datas = [NSMutableArray array];
    [treeDatas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.datas addObject:[[CityModel alloc] initWithDictionary:obj]];
    }];
    
    // TableView.
    self.tableView                = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.rowHeight      = 50.f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.tableView];
    [CityModelCell registerToTableView:self.tableView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityModelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityModelCell"];
    cell.data           = _datas[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityModelCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    CityModel     *model = cell.data;
    cell.indexPath       = indexPath;
    [cell selectedEvent];
    
    if (model.extend == NO) {
        
        // model展开后可以获取submodels
        model.extend = YES;
        
        // 数据源
        NSArray *allSubmodels = model.allSubmodels;
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:((NSRange){indexPath.row + 1, allSubmodels.count})];
        [_datas insertObjects:allSubmodels atIndexes:indexes];
        
        // 动画
        NSMutableArray *indexPaths = [NSMutableArray new];
        [allSubmodels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 + idx inSection:indexPath.section];
            [indexPaths addObject:tmpIndexPath];
        }];
        
        [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        
        // 数据源
        NSArray *allSubmodels = model.allSubmodels;
        [_datas removeObjectsInArray:allSubmodels];
        
        // 动画
        NSMutableArray *indexPaths = [NSMutableArray new];
        [allSubmodels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 + idx inSection:indexPath.section];
            [indexPaths addObject:tmpIndexPath];
        }];
        
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
        // model关闭后不可获取submodels
        model.extend = NO;
    }
}

@end
