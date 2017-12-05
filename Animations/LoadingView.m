//
//  LoadingView.m
//  Animations
//
//  Created by YouXianMing on 16/5/20.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LoadingView.h"
#import "UIView+UserInteraction.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"
#import "InfiniteRotationView.h"
#import "UIImage+ImageEffects.h"
#import "UIView+AnimationProperty.h"
#import "UIView+GlowView.h"

@interface LoadingView ()

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;

@end

@implementation LoadingView

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
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.blackView.alpha   = 0.f;
        self.messageView.alpha = 0.f;
        
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
    self.messageView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.messageView.center              = self.contentView.middlePoint;
    self.messageView.layer.cornerRadius  = self.messageView.width / 2.f;
    self.messageView.layer.masksToBounds = YES;
    self.messageView.alpha               = 0.f;
    [self addSubview:self.messageView];
    
    {
        InfiniteRotationView *rotateView = [[InfiniteRotationView alloc] initWithFrame:self.messageView.bounds];
        rotateView.speed                 = 0.95f;
        rotateView.clockWise             = YES;
        [rotateView startRotateAnimation];
        [self.messageView addSubview:rotateView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        imageView.image        = [UIImage imageNamed:@"line"];
        imageView.center       = rotateView.middlePoint;
        [rotateView addSubview:imageView];
    }
    
    UIImageView *inImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"word"]];
    inImageView.scale        = 0.3f;
    [self.messageView addSubview:inImageView];
    inImageView.center = self.messageView.middlePoint;
    
    // Start glow.
    inImageView.glowRadius            = @(2.f);
    inImageView.glowOpacity           = @(1.f);
    inImageView.glowColor             = [[UIColor colorWithRed:0.203  green:0.598  blue:0.859 alpha:1] colorWithAlphaComponent:0.95f];
    inImageView.glowDuration          = @(1.f);
    inImageView.hideDuration          = @(3.f);
    inImageView.glowAnimationDuration = @(2.f);
    [inImageView createGlowLayer];
    [inImageView insertGlowLayer];
    [inImageView startGlowLoop];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.messageView.alpha = 1.f;
    }];
}

- (void)stopLoading {
    
    [self hide];
}

@end
