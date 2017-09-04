//
//  GreenView.m
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/1.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CategoryInfoView.h"
#import "UIView+SetRect.h"
#import "CategoryModel.h"
#import "UIFont+Fonts.h"
#import "PlaceholderImageView.h"

@interface CategoryInfoView ()

@property (nonatomic, strong) PlaceholderImageView *iconImageView;
@property (nonatomic, strong) UILabel              *label;

@end

@implementation CategoryInfoView

- (void)buildSubView {
    
    self.iconImageView                     = [[PlaceholderImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 25.f, 25.f)];
    self.iconImageView.centerY             = self.height / 2.f;
    self.iconImageView.placeholderImage    = [UIImage imageNamed:@"logo-bg"];
    [self addSubview:self.iconImageView];
    
    self.label      = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.font = [UIFont HYQiHeiWithFontSize:15.f];
    self.label.left = 25.f;
    [self addSubview:self.label];
}

- (void)loadContent {
    
    CategoryModel *model         = self.data;
    self.label.text              = model.name;
    self.iconImageView.urlString = model.icon_url;
}

@end
