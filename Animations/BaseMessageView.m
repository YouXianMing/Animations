//
//  BaseMessageView.m
//  MessageView
//
//  Created by YouXianMing on 2017/1/3.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "BaseMessageView.h"

@implementation BaseMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.delayAutoHidenDuration = 2.f;
        self.autoHiden              = NO;
    }
    
    return self;
}

- (void)show {
    
    [NSException raise:NSStringFromClass([self class]) format:@"Use show method from subclass."];
}

- (void)hide {
    
    [NSException raise:NSStringFromClass([self class]) format:@"Use hide method from subclass."];
}

+ (instancetype)autoHidenWithMessageObject:(id)messageObject
                                  delegate:(id <BaseMessageViewDelegate>)delegate
                               contentView:(UIView *)contentView
                           showImmediately:(BOOL)showImmediately {

    return [[self class] new];
}

+ (instancetype)messageViewWithMessageObject:(id)messageObject
                                    delegate:(id <BaseMessageViewDelegate>)delegate
                                 contentView:(UIView *)contentView
                                     viewTag:(NSInteger)tag
                                   autoHiden:(BOOL)autoHiden
                      delayAutoHidenDuration:(NSTimeInterval)delayAutoHidenDuration
                             showImmediately:(BOOL)showImmediately {

    BaseMessageView *alertView       = [[[self class] alloc] init];
    
    alertView.messageObject          = messageObject;
    alertView.delegate               = delegate;
    alertView.contentView            = contentView;
    alertView.tag                    = tag;
    alertView.autoHiden              = autoHiden;
    alertView.delayAutoHidenDuration = delayAutoHidenDuration;
    
    showImmediately ? [alertView show] : 0;
    
    return alertView;
}

+ (instancetype)showAutoHiddenMessageViewWithMessageObject:(id)messageObject contentView:(UIView *)contentView {

    return [[self class] messageViewWithMessageObject:messageObject
                                             delegate:nil
                                          contentView:contentView
                                              viewTag:0
                                            autoHiden:YES
                               delayAutoHidenDuration:2.f
                                      showImmediately:YES];
}

+ (instancetype)showAutoHiddenMessageViewWithMessageObject:(id)messageObject delegate:(id <BaseMessageViewDelegate>)delegate
                                     contentView:(UIView *)contentView viewTag:(NSInteger)tag {

    return [[self class] messageViewWithMessageObject:messageObject
                                             delegate:delegate
                                          contentView:contentView
                                              viewTag:tag
                                            autoHiden:YES
                               delayAutoHidenDuration:2.f
                                      showImmediately:YES];
}

+ (instancetype)showManualHiddenMessageViewWithMessageObject:(id)messageObject contentView:(UIView *)contentView {
    
    return [[self class] messageViewWithMessageObject:messageObject
                                             delegate:nil
                                          contentView:contentView
                                              viewTag:0
                                            autoHiden:NO
                               delayAutoHidenDuration:2.f
                                      showImmediately:YES];
}

+ (instancetype)showManualHiddenMessageViewWithMessageObject:(id)messageObject delegate:(id <BaseMessageViewDelegate>)delegate
                                               contentView:(UIView *)contentView viewTag:(NSInteger)tag {
    
    return [[self class] messageViewWithMessageObject:messageObject
                                             delegate:delegate
                                          contentView:contentView
                                              viewTag:tag
                                            autoHiden:NO
                               delayAutoHidenDuration:2.f
                                      showImmediately:YES];
}

#pragma mark - Setter.

@synthesize contentView = _contentView;

- (void)setContentView:(UIView *)contentView {
    
    self.frame   = contentView.bounds;
    _contentView = contentView;
}

- (void)dealloc {

    NSLog(@"%@ has dealloc.", NSStringFromClass([self class]));
}

@end
