//
//  OffsetCellViewController.m
//  Animations
//
//  Created by YouXianMing on 16/4/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "OffsetCellViewController.h"
#import "YXNetworking.h"
#import "WanDouJiaModel.h"
#import "WanDouJiaModelSerializer.h"
#import "WanDouJiaParameterSerializer.h"
#import "OffsetImageCell.h"
#import "MessageView.h"
#import "OffsetHeaderView.h"
#import "LoadingView.h"
#import "GCD.h"

@interface OffsetCellViewController () <UITableViewDelegate, UITableViewDataSource, YXNetworkingDelegate>

@property (nonatomic, strong) YXNetworking      *networking;
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) WanDouJiaModel    *rootModel;
@property (nonatomic, strong) LoadingView       *showLoadingView;

@end

@implementation OffsetCellViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView                     = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate            = self;
    self.tableView.dataSource          = self;
    self.tableView.rowHeight           = 250;
    self.tableView.sectionHeaderHeight = 25.f;
    self.tableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.tableView.alpha               = 0.f;
    
    [self.tableView registerClass:[OffsetImageCell class]  forCellReuseIdentifier:@"OffsetImageCell"];
    [self.tableView registerClass:[OffsetHeaderView class] forHeaderFooterViewReuseIdentifier:@"OffsetHeaderView"];
    [self.contentView addSubview:self.tableView];
    
    self.showLoadingView             = [[LoadingView alloc] init];
    self.showLoadingView.contentView = self.loadingAreaView;
    [self.showLoadingView show];
    
    self.networking = [YXNetworking networkingWithUrlString:@"http://baobab.wandoujia.com/api/v1/feed"
                                           requestParameter:@{@"num" : @"5",
                                                              @"vc"  : @"67"}
                                                     method:kYXNetworkingGET
                                 requestParameterSerializer:[WanDouJiaParameterSerializer new]
                                     responseDataSerializer:[WanDouJiaModelSerializer new]
                                                        tag:1000
                                                   delegate:self
                                          requestSerializer:[AFHTTPRequestSerializer serializer]
                                         ResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    self.networking.serviceInfo    = @"图片列表请求";
    self.networking.networkingInfo = [NetworkingInfo new];
    self.networking.object         = self.tableView;
    [self.networking startRequest];
}

#pragma mark - UITableView's delegate.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    DailyListModel *dailyModel = self.rootModel.dailyList[section];
    
    return dailyModel.videoList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.rootModel.dailyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OffsetImageCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(OffsetImageCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    [cell cellOffset];
    
    DailyListModel *dailyModel = self.rootModel.dailyList[indexPath.section];
    VideoListModel *model      = dailyModel.videoList[indexPath.row];
    
    cell.data      = model;
    cell.indexPath = indexPath;
    [cell loadContent];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(OffsetImageCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {

    [cell cancelAnimation];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    DailyListModel *dailyModel = self.rootModel.dailyList[section];
    
    CustomHeaderFooterView *titleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OffsetHeaderView"];
    titleView.data                    = dailyModel;
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

#pragma mark - YXNetworking's delegate.

- (void)YXNetworkingRequestSucess:(YXNetworking *)networking tag:(NSInteger)tag data:(id)data {
 
    [GCDQueue executeInMainQueue:^{
        
        [self.showLoadingView hide];
        
    } afterDelaySecs:0.5f];
    
    self.rootModel = data;
    [networking.object reloadData];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.tableView.alpha = 1.f;
    }];
}

- (void)YXNetworkingRequestFailed:(YXNetworking *)networking tag:(NSInteger)tag error:(NSError *)error {

    [self.showLoadingView hide];
    [MessageView showAutoHiddenMessageViewWithMessageObject:MakeMessageViewObject(@"警告", @"网络异常,请稍后再试!") contentView:self.loadingAreaView];
}

@end
