//
//  POPBaseControl.m
//  Animations
//
//  Created by YouXianMing on 16/5/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "POPBaseControl.h"
#import "POP.h"

@interface POPBaseControl ()

@property (nonatomic, strong) UIView   *absView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView   *contentView;

@property (nonatomic) CGFloat percent;

@end

@implementation POPBaseControl

- (void)layoutSubviews {
    
    [super layoutSubviews];
    _button.frame       = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _contentView.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 动画时间
        _animationDuration = 0.4f;
        
        // 隐身的view
        _absView                        = [[UIView alloc] init];
        _absView.userInteractionEnabled = NO;
        _absView.backgroundColor        = [UIColor clearColor];
        [self addSubview:_absView];
        
        // 容器View
        _contentView                        = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.userInteractionEnabled = NO;
        [self addSubview:_contentView];
        
        // 按钮
        _button = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:_button];
        
        // 按钮事件
        [_button addTarget:self action:@selector(touchBeginOrTouchDragEnter) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        [_button addTarget:self action:@selector(touchUpInside)   forControlEvents:UIControlEventTouchUpInside];
        [_button addTarget:self action:@selector(touchDragExitOrTouchCancel)   forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchCancel];
    }
    
    return self;
}

#pragma mark - Animations.

- (void)touchUpInside {
    
    [self touchDragExitOrTouchCancel];
    
    [self controllEventActived];
    
    if (self.target && self.selector) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:self];
#pragma clang diagnostic pop
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(POPBaseControlEvent:)]) {
        
        [self.delegate POPBaseControlEvent:self];
    }
}

- (void)touchDragExitOrTouchCancel {
    
    [_absView.layer pop_removeAllAnimations];
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    scaleAnimation.toValue            = @(1);
    scaleAnimation.delegate           = self;
    scaleAnimation.duration           = _animationDuration;
    [_absView.layer pop_addAnimation:scaleAnimation forKey:nil];
}

- (void)touchBeginOrTouchDragEnter {
    
    [_absView.layer pop_removeAllAnimations];
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    scaleAnimation.toValue            = @(0);
    scaleAnimation.delegate           = self;
    scaleAnimation.duration           = _animationDuration;
    [_absView.layer pop_addAnimation:scaleAnimation forKey:nil];
}

#pragma mark - POPAnimation's delegate.

- (void)pop_animationDidApply:(POPAnimation *)anim {
    
    NSNumber *toValue = (NSNumber *)[anim valueForKeyPath:@"currentValue"];
    _percent          = (toValue.floatValue - [POPBaseControl calculateConstantWithX1:0 y1:1 x2:1 y2:0]) / [POPBaseControl calculateSlopeWithX1:0 y1:1 x2:1 y2:0];
    
    [self currentPercent:_percent];
}

#pragma mark - Overwrite by subClass.

- (void)currentPercent:(CGFloat)percent {
    
}

- (void)controllEventActived {
    
}

#pragma mark - Math.

+ (CGFloat)calculateSlopeWithX1:(CGFloat)x1 y1:(CGFloat)y1 x2:(CGFloat)x2 y2:(CGFloat)y2 {
    
    return (y2 - y1) / (x2 - x1);
}

+ (CGFloat)calculateConstantWithX1:(CGFloat)x1 y1:(CGFloat)y1 x2:(CGFloat)x2 y2:(CGFloat)y2 {
    
    return (y1*(x2 - x1) - x1*(y2 - y1)) / (x2 - x1);
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
