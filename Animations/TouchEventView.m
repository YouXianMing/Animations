//
//  TouchEventView.m
//  UITextFieldView
//
//  Created by YouXianMing on 16/7/25.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TouchEventView.h"

@interface TouchEventView ()

@property (nonatomic, strong) UIButton              *button;
@property (nonatomic, copy)   touchEventViewBlock_t  block;

@end

@implementation TouchEventView

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.button.frame      = self.bounds;
    self.contentView.frame = self.bounds;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // Init content view.
        self.contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.contentView];
        
        // Init button.
        self.button = [[UIButton alloc] initWithFrame:self.bounds];
        [self.button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        // Disabled the button.
        self.touchEnabled = NO;
    }
    
    return self;
}

+ (instancetype)touchEventViewWithFrame:(CGRect)frame block:(touchEventViewBlock_t)block {

    TouchEventView *touchEventView = [[[self class] alloc] initWithFrame:frame];
    
    if (block) {
        
        touchEventView.block = block;
        touchEventView.block(touchEventView, kTouchEventViewAddSubViews);
    }
    
    return touchEventView;
}

#pragma mark - Button event.

- (void)buttonEvent:(UIButton *)button {

    if (self.block && self.touchEnabled) {
        
        self.block(self, kTouchEventViewButtonEvent);
    }
}

#pragma mark - Setter & Getter.

- (void)setTouchEnabled:(BOOL)touchEnabled {

    _touchEnabled                      = touchEnabled;
    self.button.userInteractionEnabled = touchEnabled;
}

@end
