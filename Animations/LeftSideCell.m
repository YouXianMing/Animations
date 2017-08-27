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

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) PlaceholderImageView *iconImageView;

@end

@implementation LeftSideCell

- (void)buildSubview {
    
    self.iconImageView                  = [[PlaceholderImageView alloc] initWithFrame:CGRectMake(0, 25.f, 100.f, 100.f)];
    self.iconImageView.placeholderImage = [UIImage imageNamed:@"logo-bg"];
    [self addSubview:self.iconImageView];
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3.f, 15.f)];
    self.lineView.centerY         = [LeftSideCell cellHeightWithData:nil] / 2.f;
    self.lineView.backgroundColor = [UIColor redColor];
    [self addSubview:self.lineView];
    
    self.titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.f, [LeftSideCell cellHeightWithData:nil])];
    self.titleLabel.font = [UIFont AvenirLightWithFontSize:13.f];
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

    [self updateWithNewCellHeight:130.f animated:animated];
    
    [UIView animateWithDuration:animated ? 0.35 : 0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        [self stateNormal:NO];
        
    } completion:nil];

}

- (void)updateToNormalStateAnimated:(BOOL)animated {

    [self updateWithNewCellHeight:40.f animated:animated];
    
    [UIView animateWithDuration:animated ? 0.35 : 0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{

        [self stateNormal:YES];
        
    } completion:nil];
}

- (void)stateNormal:(BOOL)normal {
    
    if (normal) {
        
        self.lineView.alpha      = 0.f;
        self.titleLabel.x        = 5.f;
        self.titleLabel.alpha    = 0.35f;
        self.iconImageView.alpha = 0.f;
        
    } else {
        
        self.lineView.alpha      = 1.f;
        self.titleLabel.x        = 10.f;
        self.titleLabel.alpha    = 1.f;
        self.iconImageView.alpha = 1.f;
    }
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 40.f;
}

@end
