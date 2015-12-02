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
#import "WxHxD.h"

#define  FLAG_CountDownTimeCell  @"CountDownTimeCell"

@interface CountDownTimerController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray      *timesArray;
@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSTimer      *timer;

@end

@implementation CountDownTimerController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)setup {
    
    [super setup];

    [self createDataSource];
    
    [self createTableView];
    
    [self createTimer];

    [self bringTitleViewToFront];
}

- (void)createDataSource {
    
    self.timesArray = @[TIME_MODEL(@"YouXianMing", 20034),
                        TIME_MODEL(@"Aaron"      , 31),
                        TIME_MODEL(@"Nicholas"   , 1003),
                        TIME_MODEL(@"Nathaniel"  , 8089),
                        TIME_MODEL(@"Quentin"    , 394),
                        TIME_MODEL(@"Samirah"    , 345345),
                        TIME_MODEL(@"Serafina"   , 233),
                        TIME_MODEL(@"Shanon"     , 4649),
                        TIME_MODEL(@"Sophie"     , 3454),
                        TIME_MODEL(@"Steven"     , 54524),
                        TIME_MODEL(@"Saadiya"    , 235),];
}

- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Width, Height - 64)
                                                  style:UITableViewStylePlain];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CountDownTimeCell class] forCellReuseIdentifier:FLAG_CountDownTimeCell];
    [self.view addSubview:self.tableView];
}

- (void)createTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {
    
    for (int count = 0; count < _timesArray.count; count++) {
        
        TimeModel *model = _timesArray[count];
        [model countDown];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CountDownTimeCell object:nil];
}

#pragma mark - tableView代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.timesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:FLAG_CountDownTimeCell];
    cell.data        = self.timesArray[indexPath.row];
    cell.indexPath   = indexPath;
    [cell loadContent];
    
    return cell;
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

@end
