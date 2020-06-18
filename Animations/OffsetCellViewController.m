//
//  OffsetCellViewController.m
//  Animations
//
//  Created by YouXianMing on 16/4/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "OffsetCellViewController.h"
#import "OffsetCellSectionDataModel.h"
#import "OffsetImageCell.h"
#import "OffsetHeaderView.h"
#import "GCD.h"

@interface OffsetCellViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray <OffsetCellSectionDataModel *> *sectonModels;

@end

@implementation OffsetCellViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSArray *datas = @[@{@"dateString" : @"2020-06-18",
                         @"list"       : @[@{@"title"          : @"我们的征途是星辰大海 [1]",
                                             @"coverForDetail" : @"https://hbimg.huabanimg.com/95c1a74073e3fd69c9e7af637632fde7027b4d6a86124-g1qYW4_fw658",}]},
                       @{@"dateString" : @"2020-06-19",
                         @"list"       : @[@{@"title"          : @"我们的征途是星辰大海 [2]",
                                             @"coverForDetail" : @"https://hbimg.huabanimg.com/41e430a58e083b5df8b29828194d4c8cf6b8080e17e35-gRW2z5_fw658",}]},
                       @{@"dateString" : @"2020-06-20",
                         @"list"       : @[@{@"title"          : @"我们的征途是星辰大海 [3]",
                                             @"coverForDetail" : @"https://hbimg.huabanimg.com/463cda475956270d6d605ebacd865a80169a57967579f-0pe50Y_fw658",}]},
                       @{@"dateString" : @"2020-06-21",
                         @"list"       : @[@{@"title"          : @"我们的征途是星辰大海 [4]",
                                             @"coverForDetail" : @"https://hbimg.huabanimg.com/fae81cd6c474e36586a2b9327eecaf9bca46fa068c812-sdLSnP_fw658",}]},
                       @{@"dateString" : @"2020-06-22",
                         @"list"       : @[@{@"title"          : @"我们的征途是星辰大海 [5]",
                                             @"coverForDetail" : @"https://hbimg.huabanimg.com/648bc2e1a6350a1d48b331168000697696cdf4b136928-dgFED1_fw658",}]},
                       @{@"dateString" : @"2020-06-23",
                         @"list"       : @[@{@"title"          : @"我们的征途是星辰大海 [6]",
                                             @"coverForDetail" : @"https://hbimg.huabanimg.com/7de62a3fa6b4c98a9128ff73071e596cf7de898226d30-uDl8i5_fw658",}]},
                       @{@"dateString" : @"2020-06-24",
                         @"list"       : @[@{@"title"          : @"我们的征途是星辰大海 [7]",
                                             @"coverForDetail" : @"https://hbimg.huabanimg.com/85359db24a13794021bc6c3f609ce640f8a248f7b868c-PhP0iD_fw658",}]},
                       @{@"dateString" : @"2020-06-25",
                         @"list"       : @[@{@"title"          : @"我们的征途是星辰大海 [8]",
                                             @"coverForDetail" : @"https://hbimg.huabanimg.com/dae0e0a17d430af8f129113d12488f73f64043481ced1-FL88bJ_fw658",}]}];
    
    self.sectonModels = [NSMutableArray array];
    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        OffsetCellSectionDataModel *model = [[OffsetCellSectionDataModel alloc] initWithDictionary:obj];
        [self.sectonModels addObject:model];
    }];
    
    self.tableView                     = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate            = self;
    self.tableView.dataSource          = self;
    self.tableView.rowHeight           = 250;
    self.tableView.sectionHeaderHeight = 25.f;
    self.tableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    
    // Adjust iOS 11.0
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.tableView registerClass:[OffsetImageCell class]  forCellReuseIdentifier:@"OffsetImageCell"];
    [self.tableView registerClass:[OffsetHeaderView class] forHeaderFooterViewReuseIdentifier:@"OffsetHeaderView"];
    [self.contentView addSubview:self.tableView];
}

#pragma mark - UITableView's delegate.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.sectonModels[section].list.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sectonModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OffsetImageCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(OffsetImageCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [cell cellOffset];
    
    cell.data      = self.sectonModels[indexPath.section].list[indexPath.row];
    cell.indexPath = indexPath;
    [cell loadContent];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(OffsetImageCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    [cell cancelAnimation];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CustomHeaderFooterView *titleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OffsetHeaderView"];
    titleView.data                    = self.sectonModels[section];
    titleView.section                 = section;
    [titleView loadContent];
    
    return titleView;
}

#pragma mark - UIScrollView's delegate.

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSArray <OffsetImageCell *> *array = [self.tableView visibleCells];
    
    [array enumerateObjectsUsingBlock:^(OffsetImageCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj cellOffset];
    }];
}

@end
