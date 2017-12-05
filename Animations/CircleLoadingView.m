//
//  CircleLoadingView.m
//  Animations
//
//  Created by YouXianMing on 2017/1/6.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "CircleLoadingView.h"
#import "UIView+UserInteraction.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"
#import "InfiniteRotationView.h"
#import "UIImage+ImageEffects.h"
#import "UIView+AnimationProperty.h"
#import "UIView+GlowView.h"

@interface CircleLoadingView ()

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;

@end

@implementation CircleLoadingView

- (void)show {
    
    if (self.contentView) {
        
        [self.contentView addSubview:self];
        
        self.contentViewUserInteractionEnabled == NO ? [self.contentView enabledUserInteraction] : 0;
        
        [self createBlackView];
        [self createMessageView];
        
        if (self.autoHiddenDelay > 0) {
            
            [self performSelector:@selector(hide) withObject:nil afterDelay:self.autoHiddenDelay];
        }
    }
}

- (void)hide {
    
    if (self.contentView) {
        
        [self removeViews];
    }
}

- (void)removeViews {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewWillDisappear:)]) {
        
        [self.delegate baseMessageViewWillDisappear:self];
    }
    
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.blackView.alpha   = 0.f;
        self.messageView.alpha = 0.f;
        self.messageView.scale = 0.9;
        
    } completion:^(BOOL finished) {
        
        self.contentViewUserInteractionEnabled == NO ? [self.contentView disableUserInteraction] : 0;
        [self removeFromSuperview];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewDidDisappear:)]) {
            
            [self.delegate baseMessageViewDidDisappear:self];
        }
    }];
}

- (void)createBlackView {
    
    self.blackView                 = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.blackView.backgroundColor = [UIColor clearColor];
    self.blackView.alpha           = 0;
    [self addSubview:self.blackView];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewWillAppear:)]) {
        
        [self.delegate baseMessageViewWillAppear:self];
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.blackView.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewDidAppear:)]) {
            
            [self.delegate baseMessageViewDidAppear:self];
        }
    }];
}

- (void)createMessageView {
    
    // 创建信息窗体view
    self.messageView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75.f, 75.f)];
    self.messageView.center              = self.contentView.middlePoint;
    self.messageView.scale               = 1.1f;
    self.messageView.layer.cornerRadius  = 5.f;
    self.messageView.layer.masksToBounds = YES;
    self.messageView.backgroundColor     = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
    self.messageView.alpha               = 0.f;
    [self addSubview:self.messageView];
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"跳转黑圈"]];
    circleView.center       = self.messageView.middlePoint;
    [self.messageView addSubview:circleView];
    
    UIImageView *circleRotateImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"跳转白圈"]];
    circleRotateImageView.center       = self.messageView.middlePoint;
    [self.messageView addSubview:circleRotateImageView];
    [UIView animateKeyframesWithDuration:6.f delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModePaced | UIViewAnimationOptionCurveEaseInOut | UIViewKeyframeAnimationOptionRepeat | UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{
                                  
                                  [self view:circleRotateImageView startTime:0.f gap:1 / 15.f];
                                  
                                  [self view:circleRotateImageView startTime:2.f / 10.f            gap:1 / 30.f];
                                  [self view:circleRotateImageView startTime:2.f / 10.f + 1 / 10.f gap:1 / 30.f];
                                  
                                  [self view:circleRotateImageView startTime:4.f / 10.f            gap:1 / 45.f];
                                  [self view:circleRotateImageView startTime:4.f / 10.f + 1 / 15.f gap:1 / 45.f];
                                  [self view:circleRotateImageView startTime:4.f / 10.f + 2 / 15.f gap:1 / 45.f];
                                  
                                  [self view:circleRotateImageView startTime:6.f / 10.f            gap:1 / 30.f];
                                  [self view:circleRotateImageView startTime:6.f / 10.f + 1 / 10.f gap:1 / 30.f];
                                  
                                  [self view:circleRotateImageView startTime:8.f / 10.f gap:1 / 15.f];
                                  
                              } completion:nil];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.messageView.alpha = 1.f;
        self.messageView.scale = 1.f;
    }];
}

- (void)view:(UIView *)view startTime:(double)frameStartTime gap:(double)gap {
    
    CGFloat direction = 1.0f;  // -1.0f
    
    [UIView addKeyframeWithRelativeStartTime:frameStartTime + 0 * gap relativeDuration:0.0 animations:^{
        
        view.transform = CGAffineTransformMakeRotation(M_PI * 2.0f / 3.0f * direction);
    }];
    
    [UIView addKeyframeWithRelativeStartTime:frameStartTime + 1 * gap relativeDuration:0.0 animations:^{
        
        view.transform = CGAffineTransformMakeRotation(M_PI * 4.0f / 3.0f * direction);
    }];
    
    [UIView addKeyframeWithRelativeStartTime:frameStartTime + 2 * gap relativeDuration:0.0 animations:^{
        
        view.transform = CGAffineTransformMakeRotation(M_PI * 6.f / 3.0f * direction);
    }];
}

- (void)stopLoading {
    
    [self hide];
}

@end
