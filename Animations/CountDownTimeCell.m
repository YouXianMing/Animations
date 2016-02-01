//
//  CountDownTimeCell.m
//  TableViewTimer
//
//  Created by YouXianMing on 15/7/9.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "CountDownTimeCell.h"
#import "TimeModel.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"

@interface CountDownTimeCell ()

@property (nonatomic, strong) UIView   *backView;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *countdownLabel;

@end

@implementation CountDownTimeCell

- (void)setupCell {

    [self registerNSNotificationCenter];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
}

- (void)buildSubview {

    self.backView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 59.5f)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    {
        self.titleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, Width - 20, 40)];
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.font      = [UIFont HYQiHeiWithFontSize:20.f];;
        [self.backView addSubview:self.titleLabel];
        
        self.countdownLabel               = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, Width - 20, 40)];
        self.countdownLabel.textColor     = [UIColor grayColor];
        self.countdownLabel.textAlignment = NSTextAlignmentRight;
        self.countdownLabel.font          = [UIFont AvenirLightWithFontSize:15.f];
        [self.backView addSubview:self.countdownLabel];
    }
}

- (void)loadContent {

    TimeModel *model         = self.dataAdapter.data;
    self.titleLabel.text     = model.title;
    self.countdownLabel.text = [model currentTimeString];
}

- (void)dealloc {

    [self removeNSNotificationCenter];
}

#pragma mark - 通知中心
- (void)registerNSNotificationCenter {

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationCenterEvent:)
                                                 name:NSNotificationCountDownTimeCell
                                               object:nil];
}

- (void)removeNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNotificationCountDownTimeCell object:nil];
}

- (void)notificationCenterEvent:(id)sender {
    
    if (self.display) {
        
        [self loadContent];
    }
}

@end
