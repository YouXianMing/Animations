//
//  RightSideCell.m
//  SecondList
//
//  Created by YouXianMing on 2017/8/26.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "RightSideCell.h"
#import "ShopItemModel.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"
#import "PlaceholderImageView.h"

@interface RightSideCell ()

@property (nonatomic, strong) UILabel              *titleLabel;
@property (nonatomic, strong) PlaceholderImageView *iconImageView;

@end

@implementation RightSideCell

- (void)buildSubview {
    
    self.iconImageView                     = [[PlaceholderImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.iconImageView.center              = CGPointMake(30.f, 30.f);
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius  = 15.f;
    self.iconImageView.placeholderImage    = [UIImage imageNamed:@"logo-bg"];
    [self addSubview:self.iconImageView];
    
    self.titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(60.f, 0, 150.f, [RightSideCell cellHeightWithData:nil])];
    self.titleLabel.font = [UIFont HYQiHeiWithFontSize:18.f];
    [self addSubview:self.titleLabel];
}

- (void)loadContent {
 
    ShopItemModel *model = self.data;
    
    self.titleLabel.text         = model.name;
    self.iconImageView.urlString = model.icon_url;
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 60.f;
}

@end
