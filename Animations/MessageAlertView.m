//
//  MessageAlertView.m
//  Animations
//
//  Created by YouXianMing on 16/1/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "MessageAlertView.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"
#import "UIView+UserInteraction.h"
#import "POP.h"

@interface MessageAlertView ()

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;

@end

@implementation MessageAlertView

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
    
    // 创建信息label
    NSString *text          = self.message;
    UILabel *textLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 170, 0)];
    textLabel.text          = text;
    textLabel.font          = [UIFont HeitiSCWithFontSize:15.f];
    textLabel.textColor     = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.numberOfLines = 0;
    [textLabel sizeToFit];
    
    // 创建信息窗体view
    self.messageView                   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textLabel.width + 20, textLabel.height + 20)];
    self.messageView.backgroundColor   = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
    self.messageView.layer.borderWidth = 0.5f;
    self.messageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.messageView.center            = self.contentView.middlePoint;
    textLabel.center                   = self.messageView.middlePoint;
    self.messageView.alpha             = 0.f;
    [self.messageView addSubview:textLabel];
    [self addSubview:self.messageView];
    
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
