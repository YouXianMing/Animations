//
//  CustomButton.m
//  CustomButton
//
//  Created by YouXianMing on 16/5/21.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomButton.h"

@interface CustomButton ()

@property (nonatomic) BaseControlState  state;
@property (nonatomic) BOOL              enableEvent;
@property (nonatomic, strong) UILabel  *normalLabel;
@property (nonatomic, strong) UILabel  *highlightedLabel;
@property (nonatomic, strong) UILabel  *disabledLabel;
@property (nonatomic, strong) UIView   *backgroundView;
@property (nonatomic) CGFloat           animationDuration;

@end

@implementation CustomButton

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.button.frame           = self.bounds;
    self.normalLabel.frame      = self.bounds;
    self.highlightedLabel.frame = self.bounds;
    self.backgroundView.frame   = self.bounds;
    self.backgroundView.frame   = self.bounds;
    
    [self setVerticalOffset:_verticalOffset];
    [self setHorizontalOffset:_horizontalOffset];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 动画时间
        self.animationDuration = 0.15f;
        
        // 激活
        _enableEvent = YES;
        
        // 背景view
        self.backgroundView                 = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        
        // Label
        self.normalLabel               = [[UILabel alloc] initWithFrame:self.bounds];
        self.normalLabel.textAlignment = NSTextAlignmentCenter;
        self.normalLabel.textColor     = [UIColor clearColor];
        [self addSubview:self.normalLabel];
        
        self.highlightedLabel               = [[UILabel alloc] initWithFrame:self.bounds];
        self.highlightedLabel.textAlignment = NSTextAlignmentCenter;
        self.highlightedLabel.textColor     = [UIColor clearColor];
        [self addSubview:self.highlightedLabel];
        
        self.disabledLabel               = [[UILabel alloc] initWithFrame:self.bounds];
        self.disabledLabel.textAlignment = NSTextAlignmentCenter;
        self.disabledLabel.textColor     = [UIColor clearColor];
        [self addSubview:self.disabledLabel];
        
        // backgroundView
        self.backgroundView.userInteractionEnabled   = NO;
        self.normalLabel.userInteractionEnabled      = NO;
        self.highlightedLabel.userInteractionEnabled = NO;
        self.disabledLabel.userInteractionEnabled    = NO;
    }
    
    return self;
}

- (void)setTitleColor:(UIColor *)color state:(BaseControlState)state {
    
    if (state == BaseControlStateNormal) {
        
        self.normalLabel.textColor = color;
        
    } else if (state == BaseControlStateHighlighted) {
        
        self.highlightedLabel.textColor = color;
        
    } else if (state == BaseControlStateDisabled) {
        
        self.disabledLabel.textColor = color;
    }
}

#pragma mark - 重载的方法

- (void)touchEvent {
    
    if (_enableEvent == NO) {
        
        return;
    }
    
    [self changeToState:BaseControlStateNormal animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseControlTouchEvent:)]) {
        
        [self.delegate baseControlTouchEvent:self];
    }
    
    if (self.buttonEvent && self.target) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.buttonEvent withObject:self];
#pragma clang diagnostic pop
    }
}

- (void)touchDragExit {
    
    if (_enableEvent == NO) {
        
        return;
    }
    
    [self changeToState:BaseControlStateNormal animated:YES];
}

- (void)touchBegin {
    
    if (_enableEvent == NO) {
        
        return;
    }
    
    [self changeToState:BaseControlStateHighlighted animated:YES];
}

#pragma mark -

- (void)changeToState:(BaseControlState)state animated:(BOOL)animated {
    
    _state = state;
    
    if (state == BaseControlStateNormal) {
        
        _enableEvent = YES;
        [self normalStateAnimated:animated];
        
    } else if (state == BaseControlStateHighlighted) {
        
        _enableEvent = YES;
        [self highlightedAnimated:animated];
        
    } else if (state == BaseControlStateDisabled) {
        
        _enableEvent = NO;
        [self disabledAnimated:animated];
    }
}

- (void)normalStateAnimated:(BOOL)animated {
    
    if (!animated) {
        
        self.normalLabel.alpha      = 1.f;
        self.highlightedLabel.alpha = 0.f;
        self.disabledLabel.alpha    = 0.f;
        
        self.backgroundView.backgroundColor = self.normalBackgroundColor;
        
    } else {
        
        [UIView animateWithDuration:self.animationDuration delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
            
            self.normalLabel.alpha      = 1.f;
            self.highlightedLabel.alpha = 0.f;
            self.disabledLabel.alpha    = 0.f;
            
            self.backgroundView.backgroundColor = self.normalBackgroundColor;
            
        } completion:nil];
    }
}

- (void)highlightedAnimated:(BOOL)animated {
    
    if (!animated) {
        
        self.normalLabel.alpha      = 0.f;
        self.highlightedLabel.alpha = 1.f;
        self.disabledLabel.alpha    = 0.f;
        
        self.backgroundView.backgroundColor = self.highlightBackgroundColor;
        
    } else {
        
        [UIView animateWithDuration:self.animationDuration delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
            
            self.normalLabel.alpha      = 0.f;
            self.highlightedLabel.alpha = 1.f;
            self.disabledLabel.alpha    = 0.f;
            
            self.backgroundView.backgroundColor = self.highlightBackgroundColor;
            
        } completion:nil];
    }
}

- (void)disabledAnimated:(BOOL)animated {
    
    if (!animated) {
        
        self.normalLabel.alpha      = 0.f;
        self.highlightedLabel.alpha = 0.f;
        self.disabledLabel.alpha    = 1.f;
        
        self.backgroundView.backgroundColor = self.disabledBackgroundColor;
        
    } else {
        
        [UIView animateWithDuration:self.animationDuration delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
            
            self.normalLabel.alpha      = 0.f;
            self.highlightedLabel.alpha = 0.f;
            self.disabledLabel.alpha    = 1.f;
            
            self.backgroundView.backgroundColor = self.disabledBackgroundColor;
            
        } completion:nil];
    }
}

#pragma mark - 重写getter,setter方法

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.normalLabel.text      = title;
    self.highlightedLabel.text = title;
    self.disabledLabel.text    = title;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    
    _textAlignment = textAlignment;
    
    self.normalLabel.textAlignment      = textAlignment;
    self.highlightedLabel.textAlignment = textAlignment;
    self.disabledLabel.textAlignment    = textAlignment;
}

- (void)setFont:(UIFont *)font {
    
    _font = font;
    
    self.normalLabel.font      = font;
    self.highlightedLabel.font = font;
    self.disabledLabel.font    = font;
}

- (void)setVerticalOffset:(CGFloat)verticalOffset {
    
    _verticalOffset = verticalOffset;
    
    CGRect frame                = self.normalLabel.frame;
    frame.origin.y              = verticalOffset;
    self.normalLabel.frame      = frame;
    self.highlightedLabel.frame = frame;
    self.disabledLabel.frame    = frame;
}

- (void)setHorizontalOffset:(CGFloat)horizontalOffset {
    
    _horizontalOffset = horizontalOffset;
    
    CGRect frame                = self.normalLabel.frame;
    frame.origin.x              = horizontalOffset;
    self.normalLabel.frame      = frame;
    self.highlightedLabel.frame = frame;
    self.disabledLabel.frame    = frame;
}

@end
