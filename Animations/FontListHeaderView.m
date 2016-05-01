//
//  FontListHeaderView.m
//  Animations
//
//  Created by YouXianMing on 16/5/1.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "FontListHeaderView.h"
#import "UIView+SetRect.h"
#import "FontInfoModel.h"
#import "LineBackgroundView.h"

@interface FontListHeaderView ()

@property (nonatomic, strong) UILabel *fontLabel;

@end

@implementation FontListHeaderView

- (void)setupHeaderFooterView {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)buildSubview {
    
    LineBackgroundView *lineBackgroundView = [LineBackgroundView createViewWithFrame:CGRectMake(0, 0, Width, 40) lineWidth:4 lineGap:4
                                                                           lineColor:[[UIColor blackColor] colorWithAlphaComponent:0.015]];
    [self addSubview:lineBackgroundView];

    
    self.fontLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, Width - 10, 40)];
    [self addSubview:self.fontLabel];
    
    {
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 2, 20)];
        lineView.backgroundColor = [UIColor redColor];
        [self addSubview:lineView];
    }
    
    {
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5f, Width, 0.5f)];
        lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1f];
        [self addSubview:lineView];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width, 40)];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)loadContent {
    
    FontInfoModel *model = self.data;
    
    self.fontLabel.text = model.fontFamilyName;
    self.fontLabel.font = [UIFont fontWithName:model.fontFamilyName size:12.f];
}

- (void)buttonEvent {
    
    FontInfoModel *model = self.data;
    NSLog(@"Font Family Name - %@", model.fontFamilyName);
}

@end
