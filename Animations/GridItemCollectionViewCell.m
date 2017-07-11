//
//  GridItemCollectionViewCell.m
//  Animations
//
//  Created by YouXianMing on 2017/7/11.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "GridItemCollectionViewCell.h"
#import "GridItemModel.h"
#import "Masonry.h"
#import "UIColor+ForPublicUse.h"
#import "UIView+AnimationProperty.h"

@interface GridItemCollectionViewCell ()

@property (nonatomic, strong) UIView      *rightLine;
@property (nonatomic, strong) UIView      *downLine;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *titleLabel;

@end

@implementation GridItemCollectionViewCell

- (void)setupCell {
    
    self.contentView .backgroundColor = [UIColor whiteColor];
    
    // KohinoorDevanagari-Light
}

- (void)buildSubview {
    
    self.rightLine                 = [UIView new];
    self.rightLine.backgroundColor = [UIColor lineColor];
    [self.contentView addSubview:self.rightLine];
    
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.right.equalTo(self.contentView);
        make.height.equalTo(self.contentView);
        make.width.mas_equalTo(0.5f);
    }];
    
    self.downLine                 = [UIView new];
    self.downLine.backgroundColor = [UIColor lineColor];
    [self.contentView addSubview:self.downLine];
    
    [self.downLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.width.equalTo(self.contentView);
    }];
    
    self.imageView                 = [UIImageView new];
    [self.contentView addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(self.contentView).multipliedBy(0.4);
        make.height.equalTo(self.contentView).multipliedBy(0.4);
        make.center.equalTo(self.contentView);
    }];
    
    self.titleLabel               = [UILabel new];
    self.titleLabel.font          = [UIFont fontWithName:@"KohinoorDevanagari-Light" size:10.f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10.f);
        make.centerX.equalTo(self.contentView);
    }];
}

- (void)loadContent {
    
    GridItemModel *model = self.data;
    self.imageView.image = [UIImage imageNamed:model.icon];
    self.titleLabel.text = model.title;
}

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.imageView.scale             = highlighted ? 0.95 : 1.f;
        self.titleLabel.alpha            = highlighted ? 0.85 : 1.f;
        self.contentView.backgroundColor = highlighted ? [UIColor lineColor] : [UIColor whiteColor];
        
    } completion:nil];
}

@end
