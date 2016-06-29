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
#import "UITableView+CellClass.h"
#import "UIView+SetRect.h"

@interface CountDownTimerController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray  *timesArray;
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSTimer         *timer;

@end

@implementation CountDownTimerController

- (void)setup {
    
    [super setup];

    [self createDataSource];
    
    [self createTableView];
    
    [self createTimer];
}

- (void)createDataSource {
    
    self.timesArray = [NSMutableArray array];
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
    
    for (int i = 0; i < array.count; i++) {
        
        [self.timesArray addObject:[CountDownTimeCell dataAdapterWithCellReuseIdentifier:nil data:array[i] cellHeight:0 type:0]];
    }
}

- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds
                                                  style:UITableViewStylePlain];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight      = 60.f;
    [self.tableView registerCellsClass:@[cellClass(@"CountDownTimeCell", nil)]];
    [self.contentView addSubview:self.tableView];
}

- (void)createTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {
    
    for (int count = 0; count < _timesArray.count; count++) {
        
        CellDataAdapter *adapter = _timesArray[count];
        TimeModel       *model   = adapter.data;
        
        [model countDown];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCountDownTimeCell object:nil];
}

#pragma mark - tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.timesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView dequeueAndLoadContentReusableCellFromAdapter:_timesArray[indexPath.row] indexPath:indexPath];
}

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
