//
//  BaseControl.m
//  BaseButton
//
//  Created by YouXianMing on 15/8/27.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "BaseControl.h"

@interface BaseControl ()

@property (nonatomic, strong) UIView   *contentView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation BaseControl

- (void)layoutSubviews {

    [super layoutSubviews];
    
    _button.frame      = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self baseControlSetup];
    }
    
    return self;
}

- (void)baseControlSetup {
    
    _contentView                        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _contentView.userInteractionEnabled = YES;
    [self addSubview:_contentView];
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_button];
    
    // 开始点击
    [_button addTarget:self action:@selector(touchBeginOrTouchDragEnter) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    
    // 拖拽到rect外面
    [_button addTarget:self action:@selector(touchDragExitOrTouchCancel) forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchCancel];
    
    // 触发事件
    [_button addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchUpInside {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseControlTouchEvent:)]) {
        
        [self.delegate baseControlTouchEvent:self];
    }
    
    if (self.target && self.selector) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:self];
#pragma clang diagnostic pop
    }
}

- (void)touchDragExitOrTouchCancel {
    
}

- (void)touchBeginOrTouchDragEnter {
    
}

#pragma mark - setter & getter.

@synthesize enabled = _enabled;

- (void)setEnabled:(BOOL)enabled {
    
    _button.enabled = enabled;
}

- (BOOL)enabled {

    return _button.enabled;
}

@synthesize selected = _selected;

- (void)setSelected:(BOOL)selected {

    _button.selected = selected;
}

- (BOOL)selected {

    return _button.selected;
}

@end
