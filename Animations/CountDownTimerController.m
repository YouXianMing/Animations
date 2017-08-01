//
//  CountDownTimerController.m
//  Animations
//
//  Created by YouXianMing on 15/12/2.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "CountDownTimerController.h"
#import "CountDownTimeCell.h"
#import "TimeModel.h"
#import "UIView+SetRect.h"

@interface CountDownTimerController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CountDownTimerController

#pragma mark - Overwrite super class's method

- (void)setupDataSource {
    
    [super setupDataSource];
    
    NSArray *array  = @[TimeModelWithTitle(@"YouXianMing", @20034),
                        TimeModelWithTitle(@"Aaron"      , @31),
                        TimeModelWithTitle(@"Nicholas"   , @1003),
                        TimeModelWithTitle(@"Nathaniel"  , @8089),
                        TimeModelWithTitle(@"Quentin"    , @394),
                        TimeModelWithTitle(@"Samirah"    , @345345),
                        TimeModelWithTitle(@"Serafina"   , @233),
                        TimeModelWithTitle(@"Shanon"     , @4649),
                        TimeModelWithTitle(@"Sophie"     , @3454),
                        TimeModelWithTitle(@"Steven"     , @54524),
                        TimeModelWithTitle(@"Saadiya"    , @235)];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [self.adapters addObject:[CountDownTimeCell dataAdapterWithCellReuseIdentifier:nil data:array[idx] cellHeight:60 type:0]];
    }];
    
    [self createTimer];
}

- (void)registerCellsWithTableView:(UITableView *)tableView {
    
    [CountDownTimeCell registerToTableView:tableView];
}

#pragma mark - TimerEvent

- (void)createTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {
    
    for (int count = 0; count < self.adapters.count; count++) {
        
        CellDataAdapter *adapter = self.adapters[count];
        TimeModel       *model   = adapter.data;
        
        [model countDown];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCountDownTimeCell object:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *tmpCell = (CustomCell *)cell;
    tmpCell.display     = YES;
    [tmpCell loadContent];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    CustomCell *tmpCell = (CustomCell *)cell;
    tmpCell.display     = NO;
}

- (void)viewDidDisappear:(BOOL)animated {

    [self.timer invalidate];
    [super viewDidDisappear:animated];
}

@end
