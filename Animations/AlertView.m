//
//  AlertView.m
//  Animations
//
//  Created by YouXianMing on 2017/1/3.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "AlertView.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"
#import "UIView+UserInteraction.h"
#import "POP.h"

#pragma mark - AlertView

@interface AlertView ()

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;

@end

@implementation AlertView

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
    
    self.blackView                 = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha           = 0;
    [self addSubview:self.blackView];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewWillAppear:)]) {
        
        [self.delegate baseMessageViewWillAppear:self];
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.blackView.alpha = 0.25f;
        
    } completion:^(BOOL finished) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageViewDidAppear:)]) {
            
            [self.delegate baseMessageViewDidAppear:self];
        }
    }];
}

- (void)createMessageView {
    
    AlertViewMessageObject *message = self.messageObject;
    
    // 创建信息label
    NSString *text          = message.content;
    UILabel *textLabel      = [[UILabel alloc] init];
    textLabel.text          = text;
    textLabel.font          = [UIFont fontWithName:@"GillSans-LightItalic" size:16.f];
    textLabel.textColor     = [UIColor blackColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.numberOfLines = 0;
    textLabel.width         = 200.f;
    [textLabel sizeToFit];
    textLabel.width         = 200.f;
    
    // 创建信息窗体view
    self.messageView                   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textLabel.width + 50, textLabel.height + 50.f)];
    self.messageView.backgroundColor   = [[UIColor whiteColor] colorWithAlphaComponent:0.985f];
    self.messageView.center            = self.contentView.middlePoint;
    textLabel.center                   = self.messageView.middlePoint;
    self.messageView.alpha             = 0.f;
    [self.messageView addSubview:textLabel];
    [self addSubview:self.messageView];

    // 创建按钮
    if (message.buttonsTitle.count) {
        
        CGFloat buttonWidth = self.messageView.width / message.buttonsTitle.count;
        for (int i = 0; i < message.buttonsTitle.count; i++) {
            
            AlertViewButtonStyle *style = message.buttonsTitle[i];
            
            UIColor *normalColor      = (style.style == kAlertViewRedStyle ? [UIColor redColor] : [UIColor blackColor]);
            UIColor *highlightedColor = [normalColor colorWithAlphaComponent:0.5f];
            
            UIButton *button              = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth * i, self.messageView.height, buttonWidth, 50.f)];
            button.userInteractionEnabled = NO;
            button.titleLabel.font        = (style.style == kAlertViewRedStyle ?
                                             [UIFont fontWithName:@"GillSans" size:14.f] : [UIFont fontWithName:@"GillSans-Light" size:14.f]);

            [button setTitle:style.title           forState:UIControlStateNormal];
            [button setTitleColor:normalColor      forState:UIControlStateNormal];
            [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.messageView addSubview:button];
        }
        
        self.messageView.height += 50.f;
        self.messageView.center  = self.contentView.middlePoint;
        
        // Create Line.
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.messageView.height - 50.f, self.messageView.width, 0.5f)];
        lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.15f];
        [self.messageView addSubview:lineView];
        
        CGFloat lineGap = self.messageView.width / message.buttonsTitle.count;
        for (int i = 0; i < message.buttonsTitle.count; i++) {
            
            if (i == 0) {
                
                continue;
            }
            
            UIView *vtLine         = [[UIView alloc] initWithFrame:CGRectMake(i * lineGap, self.messageView.height - 50.f, 0.5f, 50.f)];
            vtLine.backgroundColor = lineView.backgroundColor;
            [self.messageView addSubview:vtLine];
        }
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
    
    scale.completionBlock = ^(POPAnimation *anim, BOOL finished) {
    
        [self.messageView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[UIButton class]]) {
                
                UIButton *button              = obj;
                button.userInteractionEnabled = YES;
            }
        }];
    };
}

- (void)buttonEvent:(UIButton *)button {

    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMessageView:event:)]) {
        
        [self.delegate baseMessageView:self event:[button titleForState:UIControlStateNormal]];
    }
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

@end

#pragma mark - AlertViewMessageObject

@implementation AlertViewMessageObject

@end

#pragma mark - AlertViewButtonStyle

@implementation AlertViewButtonStyle

@end


