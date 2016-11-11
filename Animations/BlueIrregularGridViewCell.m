//
//  BlueIrregularGridViewCell.m
//  Animations
//
//  Created by YouXianMing on 2016/11/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BlueIrregularGridViewCell.h"
#import "UIView+SetRect.h"
#import "HexColors.h"
#import "UIImage+SolidColor.h"
#import "UIFont+Fonts.h"
#import "UIImage+ImageEffects.h"
#import "UILabel+SizeToFit.h"

@interface BlueIrregularGridViewCell ()

@property (nonatomic, strong) UIButton     *button;
@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UIImageView  *iconImageView;

@end

@implementation BlueIrregularGridViewCell

- (void)setupCell {
    
    UIColor *imageColor       = [UIColor colorWithHexString:@"5688F4"];
    UIImage *normalImage      = [UIImage imageWithSize:CGSizeMake(5, 5) color:imageColor];
    UIImage *highlightedImage = [UIImage imageWithSize:CGSizeMake(5, 5) color:[imageColor colorWithAlphaComponent:0.5f]];
    
    self.button                     = [[UIButton alloc] initWithFrame:self.bounds];
    self.button.layer.cornerRadius  = 4.f;
    self.button.layer.masksToBounds = YES;
    self.button.layer.borderWidth   = 0.5f;
    self.button.layer.borderColor   = [[UIColor grayColor] colorWithAlphaComponent:0.25f].CGColor;
    [self.button setBackgroundImage:normalImage      forState:UIControlStateNormal];
    [self.button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [self addSubview:self.button];
    
    [self.button addTarget:self action:@selector(selectedEvent) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel           = [[UILabel alloc] init];
    self.titleLabel.font      = [UIFont AvenirLightWithFontSize:12.f];
    self.titleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85f];
    [self addSubview:self.titleLabel];
    
    self.iconImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ui-24px-outline-3_menu"] scaleWithFixedHeight:14]];
    [self addSubview:self.iconImageView];
}

- (void)loadContent {
    
    self.button.width = self.dataAdapter.itemWidth;    
    [self.titleLabel sizeToFitWithText:self.data config:^(UILabel *label) {
        
        label.centerY = self.height / 2.f;
        label.left    = 10.f;
    }];
    
    self.iconImageView.centerY = self.height / 2.f;
    self.iconImageView.right   = self.dataAdapter.itemWidth - 10.f;
}

@end
