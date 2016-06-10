//
//  BadgeValueView.m
//  BadgeView
//
//  Created by YouXianMing on 16/5/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BadgeValueView.h"
#import "UIView+SetRect.h"

@interface BadgeValueView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation BadgeValueView

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.sensitiveWidth     = 10;
        self.fixedHeight        = 20;
        self.sensitiveTextWidth = 4;
        self.position           = BadgePositionTopRight;
        self.font               = [UIFont systemFontOfSize:12.f];
        self.textColor          = [UIColor whiteColor];
        self.badgeColor         = [UIColor redColor];
    }
    
    return self;
}

- (void)makeEffect {

    // 标签
    self.label               = [[UILabel alloc] init];
    self.label.textColor     = self.textColor;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font          = self.font;
    [self addSubview:self.label];
    
    // 背景色
    self.backgroundColor     = self.badgeColor;
    self.width               = self.fixedHeight;
    self.height              = self.fixedHeight;
    self.layer.cornerRadius  = self.fixedHeight / 2.f;
    self.layer.masksToBounds = YES;
    
    [_contentView addSubview:self];
}

- (void)setBadgeValue:(NSString *)badgeValue animated:(BOOL)animated {

    _badgeValue = badgeValue;
    
    // 是否执行动画
    if (animated) {
        
        [UIView animateWithDuration:0.15f animations:^{
            
            self.alpha = badgeValue.length == 0 ? 0 : 1;
        }];
        
    } else {
    
        self.alpha = badgeValue.length == 0 ? 0 : 1;
    }
    
    // 如果值为空，则不执行后续操作
    if (badgeValue.length <= 0) {
        
        return;
    }
    
    // 设置文本
    self.label.text = badgeValue;
    [self.label sizeToFit];
    
    // 更新尺寸
    if (self.label.width + self.sensitiveTextWidth > self.width) {
        
        self.width += self.sensitiveWidth;
        
    } else {
        
        self.width = self.fixedHeight;
    }
    
    // 更新文本尺寸
    self.label.center = self.middlePoint;
    
    // 根据位置更新尺寸
    CGFloat offset = self.fixedHeight / 2.f;
    self.position == BadgePositionCenterLeft  ? self.left = -offset, self.centerY = self.contentView.middleY : 0;
    self.position == BadgePositionCenterRight ? self.left = self.contentView.width - offset, self.centerY = self.contentView.middleY : 0;
    
    self.position == BadgePositionTopLeft     ? self.left = -offset, self.y    = -offset : 0;
    self.position == BadgePositionTopRight    ? self.top  = -offset, self.left = self.contentView.width - offset : 0;
    
    self.position == BadgePositionBottomLeft  ? self.left = -offset, self.top = self.contentView.height - offset : 0;
    self.position == BadgePositionBottomRight ? self.left = self.contentView.width - offset, self.top = self.contentView.height - offset : 0;
}

@end
