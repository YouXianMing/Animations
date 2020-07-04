//
//  WaterfallHeaderView.m
//  Animations
//
//  Created by YouXianMing on 16/1/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "WaterfallHeaderView.h"
#import "UIView+SetRect.h"
#import "UIColor+ForPublicUse.h"
#import "WaterfallCollectionSectionHeaderData.h"

@interface WaterfallHeaderView ()

@property (nonatomic, strong) UIView  *contentView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation WaterfallHeaderView

- (void)buildSubview {
    
    self.contentView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, WaterfallHeaderView.referenceSize.height)];
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.contentView];
    
    self.titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.contentView.width - 20, self.contentView.height)];
    self.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [self.contentView addSubview:self.titleLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
    line.backgroundColor = UIColor.lineColor;
    line.bottom          = self.contentView.height;
    [self.contentView addSubview:line];
}

- (void)loadContent {
    
    WaterfallCollectionSectionHeaderData *headerData = self.sectionData.waterfallHeaderData;
    self.titleLabel.text                             = headerData.data;
}

+ (CGSize)referenceSize {
    
    return CGSizeMake(Width, 45);
}

@end
