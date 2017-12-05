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
        
        self.contentViewUserInteractionEnabled = YES;
    }
    
    return self;
}

- (void)show {
    
    [NSException raise:NSStringFromClass([self class]) format:@"Use show method from subclass."];
}

- (void)hide {
    
    [NSException raise:NSStringFromClass([self class]) format:@"Use hide method from subclass."];
}

+ (NSTimeInterval)constAutoHiddenDelaySeconds {
    
    return 2.f;
}

#pragma mark - Chain Programming.

+ (instancetype)build {
    
    return [[[self class] alloc] init];
}

- (instancetype)autoHidden {
    
    self.autoHiddenDelay = [[self class] constAutoHiddenDelaySeconds];
    return self;
}

- (instancetype)disableContentViewInteraction {
    
    self.contentViewUserInteractionEnabled = NO;
    return self;
}

- (BaseMessageView *(^)(id <BaseMessageViewDelegate> delegate))withDelegate {
    
    return ^ BaseMessageView * (id <BaseMessageViewDelegate> delegate) {
        
        self.delegate = delegate;
        return self;
    };
}

- (BaseMessageView *(^)(id messageObject))withMessage {
    
    return ^ BaseMessageView * (id messageObject) {
        
        self.messageObject = messageObject;
        return self;
    };
}

- (BaseMessageView *(^)(NSTimeInterval seconds))withAutoHiddenDelay {
    
    return ^ BaseMessageView * (NSTimeInterval seconds) {
        
        self.autoHiddenDelay = seconds;
        return self;
    };
}

- (BaseMessageView *(^)(BOOL enable))withContentViewInteractionEnable {
    
    return ^ BaseMessageView * (BOOL enable) {
        
        self.contentViewUserInteractionEnabled = enable;
        return self;
    };
}

- (BaseMessageView *(^)(NSInteger tag))withTag {
    
    return ^ BaseMessageView * (NSInteger tag) {
        
        self.tag = tag;
        return self;
    };
}

- (BaseMessageView *(^)(UIView *contentView))showIn {
    
    return ^ BaseMessageView * (UIView *contentView) {
        
        self.contentView = contentView;
        [self show];
        
        return self;
    };
}

- (BaseMessageView *(^)(void))showInKeyWindow {
    
    return ^ BaseMessageView * (void) {
        
        self.contentView = [UIApplication sharedApplication].keyWindow;
        [self show];
        
        return self;
    };
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
