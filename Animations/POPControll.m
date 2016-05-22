//
//  POPControll.m
//  POPButton
//
//  Created by YouXianMing on 16/5/22.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "POPControll.h"
#import "POP.h"

@interface POPControll () <POPAnimationDelegate>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView   *contentView;

@property (nonatomic) CGFloat percent;

@end

@implementation POPControll

- (void)layoutSubviews {

    [super layoutSubviews];
    _button.bounds      = self.bounds;
    _contentView.bounds = self.bounds;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.scale             = 0.95;
        self.sensitiveDuration = 0.4f;
        self.scaleDuration     = 0.4f;
        
        _contentView                        = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.userInteractionEnabled = NO;
        [self addSubview:_contentView];
        
        _button = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:_button];
        
        [_button addTarget:self action:@selector(scaleToSmall)   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        [_button addTarget:self action:@selector(scaleToDefault) forControlEvents:UIControlEventTouchUpInside];
        [_button addTarget:self action:@selector(scaleToDefault) forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchCancel];
    }
    
    return self;
}

#pragma mark - Animations.

- (void)scaleToDefault {

    [self.layer pop_removeAllAnimations];
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue            = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.delegate           = self;
    scaleAnimation.duration           = _scaleDuration;
    [self.layer pop_addAnimation:scaleAnimation forKey:nil];
    
    // Cancel performSelectorEvent.
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)scaleToSmall {
    
    [self.layer pop_removeAllAnimations];

    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue            = [NSValue valueWithCGSize:CGSizeMake(_scale, _scale)];
    scaleAnimation.delegate           = self;
    scaleAnimation.duration           = _scaleDuration;
    [self.layer pop_addAnimation:scaleAnimation forKey:nil];
    
    // Perform SelectorEvent after delay sensitiveDuration.
    [self performSelector:@selector(performSelectorEvent) withObject:nil afterDelay:_sensitiveDuration];
}

#pragma mark - POPAnimation's delegate.

- (void)pop_animationDidApply:(POPAnimation *)anim {
    
    NSValue *toValue = (NSValue *)[anim valueForKeyPath:@"currentValue"];
    
    CGSize size = [toValue CGSizeValue];
    _percent    = (size.height - [POPControll calculateConstantWithX1:0 y1:1 x2:1 y2:_scale]) / [POPControll calculateSlopeWithX1:0 y1:1 x2:1 y2:_scale];
    
    [self currentScalePercent:_percent];
    
    if (_delegate && [_delegate respondsToSelector:@selector(POPControll:currentScalePercent:)]) {
        
        [_delegate POPControll:self currentScalePercent:_percent];
    }
}

#pragma mark - Overwrite by subClass.

- (void)currentScalePercent:(CGFloat)percent {

    NSLog(@"%f", percent);
}

- (void)controllEventActived {

}

#pragma mark - Event.

- (void)performSelectorEvent {
    
    if (_target && _selector) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_selector withObject:self];
#pragma clang diagnostic pop
    }
    
    [self controllEventActived];
    
    if (_delegate && [_delegate respondsToSelector:@selector(POPControllEvent:)]) {
        
        [_delegate POPControllEvent:self];
    }
}

#pragma mark - Math.

+ (CGFloat)calculateSlopeWithX1:(CGFloat)x1 y1:(CGFloat)y1 x2:(CGFloat)x2 y2:(CGFloat)y2 {

    return (y2 - y1) / (x2 - x1);
}

+ (CGFloat)calculateConstantWithX1:(CGFloat)x1 y1:(CGFloat)y1 x2:(CGFloat)x2 y2:(CGFloat)y2 {
    
    return (y1*(x2 - x1) - x1*(y2 - y1)) / (x2 - x1);
}

#pragma mark - setter & getter.

- (void)setEnabled:(BOOL)enabled {

    _enabled        = enabled;
    _button.enabled = enabled;
}

@end
