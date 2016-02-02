//
//  TableViewLoadDataController.m
//  Animations
//
//  Created by YouXianMing on 16/2/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TableViewLoadDataController.h"
#import "V_2_X_Networking.h"
#import "TableViewLoadDataRootModel.h"

@interface TableViewLoadDataController () <UITableViewDelegate, UITableViewDataSource, NetworkingDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) V_2_X_Networking  *dataNetworking;

@end

@implementation TableViewLoadDataController

- (void)setup {
    
    [super setup];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.contentView addSubview:self.tableView];
    
    self.dataNetworking = [V_2_X_Networking getMethodNetworkingWithUrlString:@"https://api.app.net/stream/0/posts/stream/global"
                                                           requestDictionary:nil
                                                             requestBodyType:[HttpBodyType type]
                                                            responseDataType:[JsonDataType type]];
    self.dataNetworking.delegate = self;
    [self.dataNetworking startRequest];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark - NetworkingDelegate

- (void)requestSucess:(Networking *)networking data:(id)data {
    
    TableViewLoadDataRootModel *rootModel = [[TableViewLoadDataRootModel alloc] initWithDictionary:data];
    
    for (int i = 0; i < rootModel.data.count; i++) {
        
        DataModel *dataModel = rootModel.data[i];
        NSLog(@"\n--------------------------------------\n");
        NSLog(@"\n%@\n%@", dataModel.user.infomation.text, dataModel.user.avatar_image.url);
        NSLog(@"\n--------------------------------------\n");
    }
}

- (void)requestFailed:(Networking *)networking error:(NSError *)error {
    
    
}

@end
