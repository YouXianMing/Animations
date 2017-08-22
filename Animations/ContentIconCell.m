//
//  ContentIconCell.m
//  Animations
//
//  Created by YouXianMing on 2016/11/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ContentIconCell.h"
#import "UIButton+Inits.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"

@interface ContentIconCell ()

@property (nonatomic, strong) UIButton    *iconImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIImageView *arrowNextImageView;

@end

@implementation ContentIconCell

- (void)setupCell {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    self.iconImageView                        = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.iconImageView.left                   = 15.f;
    self.iconImageView.userInteractionEnabled = NO;
    [self addSubview:self.iconImageView];
    
    self.titleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(50.f, 0, Width - 100.f, 35.f)];
    self.titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
    self.titleLabel.font      = [UIFont fontWithName:@"KohinoorTelugu-Light" size:15.f];
    [self addSubview:self.titleLabel];
    
    self.arrowNextImageView       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    self.arrowNextImageView.right = Width - 15.f;
    [self addSubview:self.arrowNextImageView];
}

- (void)loadContent {

    NSDictionary *dic = self.data;
    
    if ([dic isKindOfClass:[NSDictionary class]]) {
        
        self.iconImageView.hidden      = NO;
        self.titleLabel.hidden         = NO;
        self.arrowNextImageView.hidden = NO;
        
        self.iconImageView.centerY     = self.dataAdapter.cellHeight / 2.f;
        self.iconImageView.normalImage = [UIImage imageNamed:dic[@"icon"]];
        
        self.titleLabel.centerY = self.dataAdapter.cellHeight / 2.f;
        self.titleLabel.text    = dic[@"title"];
        
        self.arrowNextImageView.centerY = self.dataAdapter.cellHeight / 2.f;
        
    } else {
    
        self.iconImageView.hidden      = YES;
        self.titleLabel.hidden         = YES;
        self.arrowNextImageView.hidden = YES;
    }
}

- (void)selectedEvent {

    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:self.data];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

    [UIView animateWithDuration:0.35f delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.titleLabel.x        = highlighted ? 55.f : 50.f;
        self.backgroundColor     = highlighted ? [[UIColor whiteColor] colorWithAlphaComponent:0.5f] : [UIColor whiteColor];
        self.iconImageView.scale = highlighted ? 0.95f : 1.f;
        
    } completion:nil];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 50.f;
}

@end
