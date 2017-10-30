//
//  LineLayoutCollectionViewCell.m
//  UICollectionViewLayoutExample
//
//  Created by YouXianMing on 2017/7/13.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "LineLayoutCollectionViewDebugCell.h"
#import "Masonry.h"

@interface LineLayoutCollectionViewDebugCell ()

@property (nonatomic, strong) UILabel *sectionLabel;
@property (nonatomic, strong) UILabel *rowLabel;
@property (nonatomic, strong) UIView  *areaView;

@end

@implementation LineLayoutCollectionViewDebugCell

- (void)buildSubview {
    
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.25f].CGColor;
    
    self.areaView                 = [UIView new];
    self.areaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    [self.contentView addSubview:self.areaView];
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5)).priorityHigh();
    }];
    
    self.sectionLabel           = [UILabel new];
    self.sectionLabel.font      = [UIFont systemFontOfSize:12];
    self.sectionLabel.textColor = [UIColor lightGrayColor];
    [self.areaView addSubview:self.sectionLabel];
    
    [self.sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(5.f).priorityHigh();
        make.top.mas_equalTo(5.f).priorityHigh();
    }];
    
    self.rowLabel      = [UILabel new];
    self.rowLabel.font = [UIFont systemFontOfSize:25.f];
    [self.areaView addSubview:self.rowLabel];
    
    [self.rowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-10.f).priorityHigh();
        make.bottom.mas_equalTo(-5.f).priorityHigh();
    }];
}

- (void)loadContent {
    
    self.sectionLabel.text = [NSString stringWithFormat:@"Section [%ld]", (long)self.indexPath.section];
    self.rowLabel.text     = [NSString stringWithFormat:@"%ld", (long)self.indexPath.row];
}

@end
