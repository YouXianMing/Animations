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

@interface SDWebImageController ()

@end

@implementation SDWebImageController

# pragma mark - Overwrite super class's method

- (void)setupDataSource {
    
    [super setupDataSource];
    
    // Data source.
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
    
    // Adapters.
    [picsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSURL           *url   = [NSURL URLWithString:picsArray[idx]];
        PictureModel    *model = [PictureModel pictureModelWithPictureUrl:url haveAnimated:NO];
        model.pictureUrlString = picsArray[idx];
        [self.adapters addObject:[PictureCell dataAdapterWithCellReuseIdentifier:nil data:model cellHeight:Width type:0]];
    }];
}

- (void)registerCellsWithTableView:(UITableView *)tableView {
    
    [PictureCell registerToTableView:tableView];
}

#pragma mark - TableView's Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    CustomCell *customCell = (CustomCell *)cell;
    customCell.display     = YES;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {

    CustomCell *customCell = (CustomCell *)cell;
    customCell.display     = NO;
}

@end
