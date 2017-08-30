//
//  LeftSideCell.m
//  SecondList
//
//  Created by YouXianMing on 2017/8/26.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "LeftSideCell.h"
#import "CategoryModel.h"
#import "UIView+SetRect.h"
#import "LinkageOneLevelModel.h"
#import "UIFont+Fonts.h"
#import "PlaceholderImageView.h"

@interface LeftSideCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *leftLineView;
@property (nonatomic, strong) UIView *rightLineView;
@property (nonatomic, strong) PlaceholderImageView *iconImageView;

@end

@implementation LeftSideCell

- (void)buildSubview {
    
    self.iconImageView                  = [[PlaceholderImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f)];
    self.iconImageView.placeholderImage = [UIImage imageNamed:@"logo-bg"];
    [self addSubview:self.iconImageView];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self addSubview:self.bgView];
    
    self.leftLineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 35.f, 1.f, 30.f)];
    self.leftLineView.backgroundColor = [UIColor redColor];
    [self addSubview:self.leftLineView];
    
    self.rightLineView                 = [[UIView alloc] initWithFrame:CGRectMake(99.f, 35.f, 1.f, 30.f)];
    self.rightLineView.backgroundColor = [UIColor redColor];
    [self addSubview:self.rightLineView];
    
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.f, [LeftSideCell cellHeightWithData:nil])];
    self.titleLabel.font          = [UIFont AvenirLightWithFontSize:13.f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
}

- (void)loadContent {
    
    CategoryModel *model         = self.data;
    self.titleLabel.text         = model.name;
    self.iconImageView.urlString = model.icon_url;
    
    LinkageOneLevelModel *levelModel = self.levelModel;
    if (levelModel.selected == YES) {
        
        [self stateNormal:NO];
        
    } else {

        [self stateNormal:YES];
    }
}

- (void)updateToSelectedStateAnimated:(BOOL)animated {
    
    [self animationStateNormal:NO animated:animated];
}

- (void)updateToNormalStateAnimated:(BOOL)animated {
    
    [self animationStateNormal:YES animated:animated];
}

- (void)animationStateNormal:(BOOL)normal animated:(BOOL)animated {
    
    [UIView animateWithDuration:animated ? 0.35 : 0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        [self stateNormal:normal];
        
    } completion:nil];
}

- (void)stateNormal:(BOOL)normal {
    
    if (normal) {
        
        self.leftLineView.alpha = 0.f;
        self.leftLineView.frame = CGRectMake(0, 35.f, 1.f, 0.f);
        
        self.rightLineView.alpha = 0.f;
        self.rightLineView.frame = CGRectMake(99.f, 65.f, 1.f, 0.f);
        
        self.titleLabel.alpha    = 1.f;
        self.iconImageView.alpha = 0.f;
        
        self.bgView.backgroundColor = [UIColor clearColor];
        
    } else {
        
        self.leftLineView.alpha = 1.f;
        self.leftLineView.frame = CGRectMake(0, 35.f, 1.f, 30.f);
        
        self.rightLineView.alpha = 1.f;
        self.rightLineView.frame = CGRectMake(99.f, 35.f, 1.f, 30.f);
        
        self.titleLabel.alpha    = 0.f;
        self.iconImageView.alpha = 1.f;
        
        self.bgView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1f];
    }
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 100.f;
}

@end
