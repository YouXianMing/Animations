//
//  TableViewLoadDataController.m
//  Animations
//
//  Created by YouXianMing on 16/2/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TableViewLoadDataController.h"
#import "Networking.h"
#import "TableViewLoadDataRootModel.h"
#import "LoadUrlDataCell.h"
#import "CellDataAdapter.h"
#import "NSString+LabelWidthAndHeight.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"
#import "MessageAlertView.h"
#import "GCD.h"

@interface TableViewLoadDataController () <UITableViewDelegate, UITableViewDataSource, AbsNetworkingDelegate>

@property (nonatomic, strong) UITableView                         *tableView;
@property (nonatomic, strong) Networking                          *dataNetworking;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *>  *datasArray;

@property (nonatomic, strong) MessageAlertView                    *showLoadingView;

@end

@implementation TableViewLoadDataController

- (void)setup {
    
    [super setup];
    
    [self createDataSource];
    
    [self createTableView];
    
    [self startNetworking];
}

- (void)createDataSource {
    
    self.datasArray = [NSMutableArray array];
}

- (void)startNetworking {
    
    self.showLoadingView             = [[MessageAlertView alloc] init];
    self.showLoadingView.message     = @"loading...";
    self.showLoadingView.contentView = self.contentView;
    [self.showLoadingView show];
    
    self.dataNetworking = [Networking getMethodNetworkingWithUrlString:@"https://api.app.net/stream/0/posts/stream/global"
                                                      requestParameter:nil
                                                       requestBodyType:[HttpBodyType type]
                                                      responseDataType:[JsonDataType type]];
    self.dataNetworking.delegate        = self;
    self.dataNetworking.timeoutInterval = @(15);
    [self.dataNetworking startRequest];
}

- (void)createTableView {
    
    self.tableView                = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LoadUrlDataCell class] forCellReuseIdentifier:@"LoadUrlDataCell"];
    [self.contentView addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.datasArray[indexPath.row];
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter = adapter;
    cell.indexPath   = indexPath;
    [cell loadContent];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.datasArray[indexPath.row];
    
    return adapter.cellHeight;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {

    LoadUrlDataCell *dataCell = (LoadUrlDataCell *)[tableView cellForRowAtIndexPath:indexPath];
    [dataCell cancelAnimation];
}

#pragma mark - NetworkingDelegate

- (void)requestSucess:(Networking *)networking data:(id)data {
    
    [self.showLoadingView hide];
    TableViewLoadDataRootModel *rootModel = [[TableViewLoadDataRootModel alloc] initWithDictionary:data];
    
    if (rootModel.meta.code.integerValue == 200) {
        
        [GCDQueue executeInGlobalQueue:^{
            
            for (int i = 0; i < rootModel.data.count; i++) {
                
                DataModel *dataModel = rootModel.data[i];
                
                if (dataModel.user.infomation.text.length <= 0) {
                    
                    continue;
                }
                
                NSDictionary *fontInfo   = @{NSFontAttributeName: [UIFont HeitiSCWithFontSize:14.f]};
                CGFloat       height     = [dataModel.user.infomation.text heightWithStringAttribute:fontInfo fixedWidth:Width - 80];
                CGFloat       cellHeight = height <= 50 ? 10 + 50 + 10 : 10 + height + 10;
                CellDataAdapter *dataAdapter = [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"LoadUrlDataCell" data:dataModel
                                                                                            cellHeight:cellHeight cellType:0];
                [self.datasArray addObject:dataAdapter];
            }
            
            [GCDQueue executeInMainQueue:^{
                
                NSMutableArray *indexPaths = [NSMutableArray array];
                for (int i = 0; i < self.datasArray.count; i++) {
                    
                    [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
                }
                
                [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            }];
        }];
        
    } else {
        
        AbstractAlertView *alertView     = [[MessageAlertView alloc] init];
        alertView.message                = @"No data now.";
        alertView.contentView            = self.contentView;
        alertView.autoHiden              = YES;
        alertView.delayAutoHidenDuration = 2.f;
        [alertView show];
    }
}

- (void)requestFailed:(Networking *)networking error:(NSError *)error {
    
    [self.showLoadingView hide];
    AbstractAlertView *alertView     = [[MessageAlertView alloc] init];
    alertView.message                = @"Network error.";
    alertView.contentView            = self.contentView;
    alertView.autoHiden              = YES;
    alertView.delayAutoHidenDuration = 2.f;
    [alertView show];
}

@end
