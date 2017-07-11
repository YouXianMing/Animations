//
//  HorizontalPicItemCell.m
//  Animations
//
//  Created by YouXianMing on 2017/7/11.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "HorizontalPicItemCell.h"
#import "Masonry.h"
#import "HorizontalPicItemModel.h"

@interface HorizontalPicItemCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation HorizontalPicItemCell

- (void)setupCell {
    
    self.contentView.layer.masksToBounds = YES;
}

- (void)buildSubview {
    
    self.iconImageView             = [UIImageView new];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.iconImageView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
    }];
}

- (void)loadContent {
    
    HorizontalPicItemModel *model = self.data;
    self.iconImageView.image      = model.iconImage;
}

@end
