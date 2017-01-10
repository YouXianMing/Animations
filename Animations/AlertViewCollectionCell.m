//
//  AlertViewCollectionCell.m
//  Animations
//
//  Created by YouXianMing on 2017/1/10.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "AlertViewCollectionCell.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"
#import "UIFont+Fonts.h"

@interface AlertViewCollectionCell ()

@property (nonatomic) UIView *rightLineView;

@property (nonatomic, strong) UIView  *labelContentView;
@property (nonatomic, strong) UILabel *backgroundTitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AlertViewCollectionCell

- (void)buildSubview {

    UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5f, self.width, 0.5f)];
    lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self addSubview:lineView];
    
    self.rightLineView                 = [[UIView alloc] initWithFrame:CGRectMake(self.width - 0.5f, 0.f, 0.5f, self.height)];
    self.rightLineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self addSubview:self.rightLineView];
    
    self.labelContentView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.labelContentView];
    
    self.backgroundTitleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width * 1.3f, 40.f)];
    self.backgroundTitleLabel.center        = self.labelContentView.middlePoint;
    self.backgroundTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.backgroundTitleLabel.font          = [UIFont fontWithName:@"GillSans-LightItalic" size:16.f];
    self.backgroundTitleLabel.angle         = M_PI_4;
    self.backgroundTitleLabel.alpha         = 0.f;
    self.backgroundTitleLabel.textColor     = [UIColor redColor];
    [self.labelContentView addSubview:self.backgroundTitleLabel];
    
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width * 1.3f, 40.f)];
    self.titleLabel.center        = self.labelContentView.middlePoint;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font          = [UIFont fontWithName:@"GillSans-LightItalic" size:16.f];
    self.titleLabel.angle         = M_PI_4;
    self.titleLabel.alpha         = 1.f;
    self.titleLabel.textColor     = [UIColor blackColor];
    [self.labelContentView addSubview:self.titleLabel];
}

- (void)loadContent {

    self.indexPath.row % 2         == 0 ? (self.rightLineView.hidden = NO) : (self.rightLineView.hidden = YES);
    self.titleLabel.text           = self.data;
    self.backgroundTitleLabel.text = self.data;
}

- (void)setHighlighted:(BOOL)highlighted {

    [super setHighlighted:highlighted];
    
    [UIView animateKeyframesWithDuration:0.35f delay:0.f options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        
        self.backgroundColor            = highlighted ? [[UIColor grayColor] colorWithAlphaComponent:0.15f] : [UIColor whiteColor];
        self.titleLabel.alpha           = highlighted ? 0.f : 1.f;
        self.backgroundTitleLabel.alpha = highlighted ? 1.f : 0.f;
        self.labelContentView.scale     = highlighted ? 0.975f : 1.f;
        
    } completion:nil];
}

@end
