//
//  SDWebImageController.m
//  Animations
//
//  Created by YouXianMing on 16/1/1.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SDWebImageController.h"
#import "PictureCell.h"
#import "PictureModel.h"
#import "UIView+SetRect.h"
#import "UITableView+CellClass.h"

@interface SDWebImageController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray   *modelsArray;
@property (nonatomic, strong) UITableView      *tableView;

@end

@implementation SDWebImageController

- (void)setup {

    [super setup];
    
    // 初始化数据源
    NSArray *picsArray = @[@"http://pic.cnitblog.com/avatar/607542/20140226182241.png",
                           @"http://pic.cnitblog.com/avatar/751954/20150430140947.png",
                           @"http://pic.cnitblog.com/avatar/680363/20150315172929.png",
                           @"http://pic.cnitblog.com/avatar/490617/20140612182827.png",
                           @"http://pic.cnitblog.com/avatar/77734/20140925202137.png",
                           @"http://pic.cnitblog.com/avatar/726558/20150302212034.png",
                           @"http://pic.cnitblog.com/avatar/619104/20140622195607.png",
                           @"http://pic.cnitblog.com/avatar/695863/20150416154015.png",
                           @"http://pic.cnitblog.com/avatar/526391/20141226102235.png",
                           @"http://pic.cnitblog.com/avatar/485855/20140824172432.png",
                           @"http://pic.cnitblog.com/avatar/741774/20150408141002.png",
                           @"http://pic.cnitblog.com/avatar/618574/20140329230350.png"];

    self.modelsArray = [NSMutableArray array];
    for (int count = 0; count < picsArray.count; count++) {
        
        NSURL           *url         = [NSURL URLWithString:picsArray[count]];
        PictureModel    *model       = [PictureModel pictureModelWithPictureUrl:url haveAnimated:NO];
        model.pictureUrlString       = picsArray[count];
        [_modelsArray addObject:[PictureCell dataAdapterWithCellReuseIdentifier:nil data:model cellHeight:0 type:0]];
    }
    
    // 初始化tableView
    self.tableView                 = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight       = Width;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView registerCellsClass:@[cellClass(@"PictureCell", nil)]];
    [self.contentView addSubview:self.tableView];
}

#pragma mark - TableView's Delegate & DataSource.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView dequeueAndLoadContentReusableCellFromAdapter:_modelsArray[indexPath.row] indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    CustomCell *customCell = (CustomCell *)cell;
    customCell.display     = YES;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {

    CustomCell *customCell = (CustomCell *)cell;
    customCell.display     = NO;
}

@end
