//
//  LoadingView.m
//  Animations
//
//  Created by YouXianMing on 16/6/1.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LoadingView.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"
#import "UIView+UserInteraction.h"
#import "InfiniteRotationView.h"
#import "UIImage+ImageEffects.h"
#import "POP.h"

@interface LoadingView ()

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;

@end

@implementation LoadingView

- (void)setContentView:(UIView *)contentView {
    
    self.frame = contentView.bounds;
    [super setContentView:contentView];
}

- (void)show {
    
    if (self.contentView) {
        
        [self.contentView addSubview:self];
        
        [self.contentView enabledUserInteraction];
        [self createBlackView];
        [self createMessageView];
        
        if (self.autoHiden) {
            
            [self performSelector:@selector(hide) withObject:nil afterDelay:self.delayAutoHidenDuration];
        }
    }
}

- (void)hide {
    
    if (self.contentView) {
        
        [self removeViews];
    }
}

- (void)createBlackView {
    
    self.blackView                 = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha           = 0;
    [self addSubview:self.blackView];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.blackView.alpha = 0.25f;
    }];
}

- (void)createMessageView {
    
    // 创建信息窗体view
    self.messageView                    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.messageView.backgroundColor    = [[UIColor blackColor] colorWithAlphaComponent:0.45f];
    self.messageView.layer.cornerRadius = 3.f;
    self.messageView.center             = self.contentView.middlePoint;
    self.messageView.alpha              = 0.f;
    [self addSubview:self.messageView];
    
    {
        InfiniteRotationView *rotateView = [[InfiniteRotationView alloc] initWithFrame:self.messageView.bounds];
        rotateView.speed                 = 1.f;
        [rotateView startRotateAnimation];
        [self.messageView addSubview:rotateView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rotateCircle"]];
        imageView.center       = rotateView.middlePoint;
        [rotateView addSubview:imageView];
    }
    
    {
        InfiniteRotationView *rotateView = [[InfiniteRotationView alloc] initWithFrame:self.messageView.bounds];
        rotateView.speed                 = 0.5f;
        rotateView.clockWise             = NO;
        [rotateView startRotateAnimation];
        [self.messageView addSubview:rotateView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"rotateCircle"] scaleWithFixedWidth:25.f]];
        imageView.center       = rotateView.middlePoint;
        [rotateView addSubview:imageView];
    }
    
    // 执行动画
    POPBasicAnimation  *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alpha.toValue             = @(1.f);
    alpha.duration            = 0.3f;
    [self.messageView pop_addAnimation:alpha forKey:nil];
    
    POPSpringAnimation *scale = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scale.fromValue           = [NSValue valueWithCGSize:CGSizeMake(1.75f, 1.75f)];
    scale.toValue             = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scale.dynamicsTension     = 1000;
    scale.dynamicsMass        = 1.3;
    scale.dynamicsFriction    = 10.3;
    scale.springSpeed         = 20;
    scale.springBounciness    = 15.64;
    [self.messageView.layer pop_addAnimation:scale forKey:nil];
}

- (void)removeViews {
    
    [UIView animateWithDuration:0.2f animations:^{
        
        self.blackView.alpha       = 0.f;
        self.messageView.alpha     = 0.f;
        self.messageView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
        
    } completion:^(BOOL finished) {
        
        [self.contentView disableUserInteraction];
        [self removeFromSuperview];
    }];
}

@end
