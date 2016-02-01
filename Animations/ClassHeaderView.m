//
//  ClassHeaderView.m
//  HeaderViewTapAnimation
//
//  Created by YouXianMing on 15/9/16.
//  Copyright (c) 2015年 ZiPeiYi. All rights reserved.
//

#import "ClassHeaderView.h"
#import "ClassModel.h"
#import "UIView+SetRect.h"

@interface ClassHeaderView ()

@property (nonatomic, strong) UIButton   *button;
@property (nonatomic, strong) RotateView *rotateView;

@property (nonatomic, strong) UILabel    *normalClassNameLabel;
@property (nonatomic, strong) UILabel    *highClassNameLabel;

@end

@implementation ClassHeaderView

- (void)buildSubview {
    
    // 白色背景
    UIView *backgroundView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    
    // 灰色背景
    UIView *contentView         = [[UIView alloc] initWithFrame:CGRectMake(0, 2, Width, 26)];
    contentView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.05f];
    [self addSubview:contentView];
    
    UIView *line1         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5)];
    line1.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [contentView addSubview:line1];
    
    UIView *line2         = [[UIView alloc] initWithFrame:CGRectMake(0, 25.5f, Width, 0.5)];
    line2.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [contentView addSubview:line2];

    // 按钮
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
    [self.button addTarget:self
                    action:@selector(buttonEvent:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
    
    // 旋转的view
    self.rotateView                = [[RotateView alloc] initWithFrame:CGRectMake(Width - 25, 5, 20, 20)];
    self.rotateView.rotateDuration = 0.25f;
    [self addSubview:self.rotateView];
    
    // 箭头图片
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20 / 3.f, 36 / 3.f)];
    arrowImageView.image        = [UIImage imageNamed:@"arrows_next"];
    arrowImageView.center       = self.rotateView.middlePoint;
    [self.rotateView addSubview:arrowImageView];
    
    
    self.normalClassNameLabel      = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 26)];
    self.normalClassNameLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:12.f];
    [contentView addSubview:self.normalClassNameLabel];
    
    self.highClassNameLabel           = [[UILabel alloc] initWithFrame:self.normalClassNameLabel.frame];
    self.highClassNameLabel.font      = self.normalClassNameLabel.font;
    self.highClassNameLabel.textColor = [UIColor redColor];
    [contentView addSubview:self.highClassNameLabel];
}

- (void)buttonEvent:(UIButton *)button {

    if (self.delegate && [self.delegate respondsToSelector:@selector(customHeaderFooterView:event:)]) {
        
        [self.delegate customHeaderFooterView:self event:nil];
    }
}

- (void)loadContent {

    ClassModel *model = self.data;
    
    _normalClassNameLabel.text = model.className;
    _highClassNameLabel.text   = model.className;
}

- (void)normalStateAnimated:(BOOL)animated {

    [self.rotateView changeToUpAnimated:animated];
    
    if (animated == YES) {
        
        [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{

            _normalClassNameLabel.alpha = 1.f;
            _normalClassNameLabel.frame = CGRectMake(10, 0, 100, 26);
            _highClassNameLabel.alpha   = 0.f;
            _highClassNameLabel.frame   = CGRectMake(10, 0, 100, 26);

        } completion:^(BOOL finished) {
            
        }];
        
    } else {
    
        _normalClassNameLabel.alpha = 1.f;
        _normalClassNameLabel.frame = CGRectMake(10, 0, 100, 26);
        _highClassNameLabel.alpha   = 0.f;
        _highClassNameLabel.frame   = CGRectMake(10, 0, 100, 26);
    }
}

- (void)extendStateAnimated:(BOOL)animated {

    [self.rotateView changeToRightAnimated:animated];
    
    if (animated == YES) {
        
        [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            _normalClassNameLabel.alpha = 0.f;
            _normalClassNameLabel.frame = CGRectMake(10 + 10, 0, 100, 26);
            _highClassNameLabel.alpha   = 1.f;
            _highClassNameLabel.frame   = CGRectMake(10 + 10, 0, 100, 26);
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else {
        
        _normalClassNameLabel.alpha = 0.f;
        _normalClassNameLabel.frame = CGRectMake(10 + 10, 0, 100, 26);
        _highClassNameLabel.alpha   = 1.f;
        _highClassNameLabel.frame   = CGRectMake(10 + 10, 0, 100, 26);
    }
}

@end
