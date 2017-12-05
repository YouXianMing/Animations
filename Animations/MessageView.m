//
//  MessageView.m
//  Animations
//
//  Created by YouXianMing on 2017/1/3.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "MessageView.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"
#import "UIView+UserInteraction.h"
#import "POP.h"

#pragma mark - MessageViewObject

@interface MessageView ()

@property (nonatomic, strong)  UIButton  *blackView;
@property (nonatomic, strong)  UIView    *messageView;

@end

@implementation MessageView

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

- (void)createBlackView {
    
    self.blackView                 = [[UIButton alloc] initWithFrame:self.contentView.bounds];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha           = 0;
    [self addSubview:self.blackView];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewWillAppear:)]) {
        
        [self.delegate baseMessageViewWillAppear:self];
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.blackView.alpha = 0.1f;
        
    } completion:^(BOOL finished) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewDidAppear:)]) {
            
            [self.delegate baseMessageViewDidAppear:self];
        }
    }];
}

- (void)createMessageView {
    
    MessageViewObject *object = self.messageObject;
    
    // 创建标题label(如果有,则创建)
    UILabel *titleLabel = nil;
    if (object.title.length) {
        
        titleLabel               = [[UILabel alloc] init];
        titleLabel.text          = object.title;
        titleLabel.textColor     = [UIColor yellowColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font          = [UIFont HeitiSCWithFontSize:15.f];
        [titleLabel sizeToFit];
    }
    
    // 创建信息label
    NSString *text             = object.content;
    UILabel *contentLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 210, 0)];
    contentLabel.text          = text;
    contentLabel.font          = [UIFont HeitiSCWithFontSize:14.f];
    contentLabel.textColor     = [UIColor whiteColor];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 0;
    [contentLabel sizeToFit];
    
    // 创建信息窗体view
    self.messageView                   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentLabel.width + 20, contentLabel.height + 20)];
    self.messageView.backgroundColor   = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
    self.messageView.layer.borderWidth = 0.5f;
    self.messageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.messageView.center            = self.contentView.middlePoint;
    contentLabel.center                = self.messageView.middlePoint;
    self.messageView.alpha             = 0.f;
    [self.messageView addSubview:contentLabel];
    [self addSubview:self.messageView];
    
    if (titleLabel) {
        
        [self.messageView addSubview:titleLabel];
        titleLabel.top          = 10.f;
        titleLabel.centerX      = self.messageView.middleX;
        contentLabel.top        = titleLabel.bottom + 10.f;
        self.messageView.height = contentLabel.bottom + 10.f;
        self.messageView.center = self.contentView.middlePoint;
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
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewWillDisappear:)]) {
        
        [self.delegate baseMessageViewWillDisappear:self];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        
        self.blackView.alpha       = 0.f;
        self.messageView.alpha     = 0.f;
        self.messageView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
        
    } completion:^(BOOL finished) {
        
        self.contentViewUserInteractionEnabled == NO ? [self.contentView disableUserInteraction] : 0;
        [self removeFromSuperview];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewDidDisappear:)]) {
            
            [self.delegate baseMessageViewDidDisappear:self];
        }
    }];
}

+ (NSTimeInterval)constAutoHiddenDelaySeconds {
    
    return 2.5f;
}

@end

#pragma mark - MessageViewObject

@implementation MessageViewObject

+ (instancetype)messageViewObjectWithTitle:(NSString *)title content:(NSString *)content {

    MessageViewObject *object = [[[self class] alloc] init];
    object.title              = title;
    object.content            = content;
    
    return object;
}

@end
