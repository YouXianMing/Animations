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

@interface TableViewTapAnimationController ()

@end

@implementation TableViewTapAnimationController

- (void)setupDataSource {
    
    [super setupDataSource];
    
    // Models
    NSArray *array = @[[TapAnimationModel modelWithName:@"YouXianMing" selected:YES],
                       [TapAnimationModel modelWithName:@"NoZuoNoDie"  selected:NO],
                       [TapAnimationModel modelWithName:@"Animations"  selected:NO]];
    
    // Adapters
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [self.adapters addObject:[TableViewTapAnimationCell dataAdapterWithCellReuseIdentifier:nil data:array[idx] cellHeight:80 type:0]];
    }];
}

- (void)registerCellsWithTableView:(UITableView *)tableView {
    
    [TableViewTapAnimationCell registerToTableView:tableView];
}

@end
