//
//  DrawRectViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/8/24.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "DrawRectViewController.h"
#import "StudyInfoCell.h"
#import "StudyInfoModel.h"
#import "InterpolationTypeCell.h"

@interface DrawRectViewController ()

@end

@implementation DrawRectViewController

- (void)registerCellsWithTableView:(UITableView *)tableView {
    
    [StudyInfoCell         registerToTableView:tableView];
    [InterpolationTypeCell registerToTableView:tableView];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    StudyInfoModel *model = [StudyInfoModel new];
    model.title           = @"语文";
    [model.times addObject:studyTimeModel(@"0", 0)];
    [model.times addObject:studyTimeModel(@"5", 0.1)];
    [model.times addObject:studyTimeModel(@"10", 0.18)];
    [model.times addObject:studyTimeModel(@"15", 0.34)];
    [model.times addObject:studyTimeModel(@"20", 0.57)];
    [model.times addObject:studyTimeModel(@"25", 0.60)];
    [model.times addObject:studyTimeModel(@"30", 0.75)];
    [model.times addObject:studyTimeModel(@"35", 0.93)];
    
    [self.adapters addObject:[StudyInfoCell         fixedHeightTypeDataAdapterWithData:model]];
    [self.adapters addObject:[InterpolationTypeCell fixedHeightTypeDataAdapter]];
}

@end
