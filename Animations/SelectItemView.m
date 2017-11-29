//
//  SelectItemView.m
//  Animations
//
//  Created by YouXianMing on 2017/11/28.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "SelectItemView.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "UIButton+Inits.h"

@interface SelectItemView ()

@property (nonatomic, strong) UIButton    *button;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UIImageView *iconNext;

@end

@implementation SelectItemView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
 
        self.titleLabel      = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont HeitiSCWithFontSize:14.f];
        [self addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        [self addSubview:self.contentLabel];
        
        self.iconNext = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
        [self addSubview:self.iconNext];
        
        self.button = [[UIButton alloc] init];
        [self addSubview:self.button];
        [self.button addTarget:self action:@selector(buttonEvent:)];
    }
    
    return self;
}

- (void)buttonEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectItemViewTapEvent:)]) {

        [self.delegate selectItemViewTapEvent:self];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.iconNext.right   = self.width - 15.f;
    self.iconNext.centerY = self.middleY;
    
    self.button.frame = self.bounds;
}

#pragma mark - Setter & Getter

- (void)setTitle:(NSString *)title {
    
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    
    self.titleLabel.left    = 15.f;
    self.titleLabel.centerY = self.middleY;
}

- (NSString *)title {
    
    return self.titleLabel.text;
}

- (void)setContent:(NSAttributedString *)content {
    
    self.contentLabel.attributedText = content;
    self.contentLabel.width          = Width - self.titleLabel.right - 45.f;
    [self.contentLabel sizeToFit];
    self.contentLabel.centerY        = self.middleY;
    self.contentLabel.right          = Width - 30.f;
}

- (NSAttributedString *)content {
    
    return self.contentLabel.attributedText;
}

@end
