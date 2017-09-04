//
//  RedView.m
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/1.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ShopItemInfoView.h"
#import "ShopItemModel.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"
#import "PlaceholderImageView.h"
#import "AttributedStringConfigHelper.h"

@interface ShopItemInfoView ()

@property (nonatomic, strong) UILabel              *idLabel;
@property (nonatomic, strong) UILabel              *label;
@property (nonatomic, strong) PlaceholderImageView *iconImageView;

@end

@implementation ShopItemInfoView

- (void)buildSubView {
    
    self.iconImageView                     = [[PlaceholderImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 25.f, 25.f)];
    self.iconImageView.centerY             = self.height / 2.f;
    self.iconImageView.placeholderImage    = [UIImage imageNamed:@"logo-bg"];
    [self addSubview:self.iconImageView];
    
    self.label      = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.font = [UIFont HYQiHeiWithFontSize:15.f];
    self.label.left = 25.f;
    [self addSubview:self.label];
    
    self.idLabel               = [[UILabel alloc] initWithFrame:self.bounds];
    self.idLabel.textAlignment = NSTextAlignmentRight;
    self.idLabel.right         = self.width - 10.f;
    [self addSubview:self.idLabel];
}

- (void)loadContent {
    
    ShopItemModel *model         = self.data;
    self.label.text              = model.name;
    self.iconImageView.urlString = model.icon_url;
    
    self.idLabel.attributedText = [NSMutableAttributedString mutableAttributedStringWithString:[NSString stringWithFormat:@"¥%.1f",model.itemId.floatValue] config:^(NSString *string, NSMutableArray<AttributedStringConfig *> *configs) {
        
        NSRange fullRange = NSMakeRange(0, string.length);
        NSRange partRange = NSMakeRange(0, 1);
        
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[UIColor orangeColor] range:fullRange]];
        [configs addObject:[ForegroundColorAttributeConfig configWithColor:[UIColor lightGrayColor] range:partRange]];
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont fontWithName:@"GillSans-LightItalic" size:15.f] range:fullRange]];
        [configs addObject:[FontAttributeConfig configWithFont:[UIFont fontWithName:@"GillSans-LightItalic" size:10.f] range:partRange]];
    }];
}

@end
