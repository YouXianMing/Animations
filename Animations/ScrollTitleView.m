//
//  ScrollTitleView.m
//  Animations
//
//  Created by YouXianMing on 16/3/13.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ScrollTitleView.h"
#import "UIFont+Fonts.h"
#import "UIView+GlowView.h"

@interface ScrollTitleView ()

@property (nonatomic, strong) UILabel *frontLabel;
@property (nonatomic, strong) UILabel *backLabel;

@end

@implementation ScrollTitleView

- (void)buildSubViews {
    
    self.backLabel               = [[UILabel alloc] initWithFrame:self.bounds];
    self.backLabel.text          = self.title;
    self.backLabel.font          = [UIFont HeitiSCWithFontSize:16.f];
    self.backLabel.textAlignment = NSTextAlignmentCenter;
    self.backLabel.textColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    [self addSubview:self.backLabel];
    
    self.frontLabel               = [[UILabel alloc] initWithFrame:self.bounds];
    self.frontLabel.text          = self.title;
    self.frontLabel.font          = [UIFont HeitiSCWithFontSize:16.f];
    self.frontLabel.textAlignment = NSTextAlignmentCenter;
    self.frontLabel.textColor     = [UIColor redColor];
    [self addSubview:self.frontLabel];
}

@synthesize inputValue = _inputValue;

- (void)setInputValue:(CGFloat)inputValue {
    
    _inputValue           = inputValue;
    self.frontLabel.alpha = inputValue;
    self.backLabel.alpha  = 1 - inputValue;
}

@end
