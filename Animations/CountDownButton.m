//
//  CountDownButton.m
//  PictureBooks
//
//  Created by YouXianMing on 2017/7/4.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CountDownButton.h"
#import "GCD.h"

@interface CountDownButton ()

@property (nonatomic, strong) UIView   *nomalContentView;
@property (nonatomic, strong) UIView   *countDownContentView;
@property (nonatomic, strong) GCDTimer *timer;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic)         BOOL      isRunning;
@property (nonatomic)         NSInteger count;

@end

@implementation CountDownButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 内容view
        self.nomalContentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.nomalContentView];
        
        // 内容view
        self.countDownContentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.countDownContentView];
        
        // 配置内容view
        [self configNomalContentView:self.nomalContentView countDownContentView:self.countDownContentView];
        
        // 按钮
        self.button = [[UIButton alloc] initWithFrame:self.bounds];
        [self.button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        [self.button addObserver:self forKeyPath:@"highlighted"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                         context:nil];
        
        // 显示普通的view,隐藏倒计时的view
        [self showNormalContentView:YES];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"highlighted"]) {
        
        NSNumber *new = [change objectForKey:@"new"];
        NSNumber *old = [change objectForKey:@"old"];
        
        if (old && [new isEqualToNumber:old]) {
            
            // NSLog(@"Highlight state has not changed");
            
        } else {
            
            [self isHighlighted:[object isHighlighted]];
        }
    }
}

- (void)showNormalContentView:(BOOL)show {
    
    [UIView animateWithDuration:0.1f animations:^{
        
        self.nomalContentView.alpha     = show ? 1 : 0;
        self.countDownContentView.alpha = show ? 0 : 1;
    }];
}

- (void)buttonEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(countDownButtonDidTaped:)]) {
        
        [self.delegate countDownButtonDidTaped:self];
    }
}

- (void)start {
    
    NSParameterAssert(self.countDownStrings);
    
    // 防止重复开始
    if (self.isRunning == NO) {
        
        self.isRunning = YES;
        
    } else {
        
        return;
    }
    
    [self showNormalContentView:NO];
    
    self.button.userInteractionEnabled = NO;
    self.count                         = self.countDownStrings.count;
    
    __weak CountDownButton *weakSelf = self;
    
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        if (weakSelf.count <= 0) {
            
            [weakSelf reset];
            [weakSelf.timer destroy];
        }
        
        NSInteger index = weakSelf.count - 1;
        if (index >= 0) {
            
            [weakSelf countDownEventWithString:weakSelf.countDownStrings[weakSelf.count - 1]];
            weakSelf.count--;
        }
        
    } timeIntervalWithSecs:1.f];
    [self.timer start];
}

- (void)reset {
    
    [self.timer destroy];
    self.timer = nil;
    
    self.button.userInteractionEnabled = YES;
    self.isRunning                     = NO;
    [self showNormalContentView:YES];
    NSLog(@"reset");
}

- (void)countDownEventWithString:(id)string {
    
}

- (void)configNomalContentView:(UIView *)normalContentView countDownContentView:(UIView *)countDownContentView {
    
}

- (void)setNormalString:(id)normalString {
    
}

- (void)isHighlighted:(BOOL)highlighted {
    
    NSLog(@"%@", highlighted ? @"高亮状态" : @"普通状态");
}

+ (instancetype)countDownButtonWithFrame:(CGRect)frame
                                delegate:(id <CountDownButtonDelegate>)delegate
                        countDownStrings:(NSArray *)countDownStrings
                            normalString:(id)normalString {
    
    CountDownButton *button = [[[self class] alloc] initWithFrame:frame];
    button.delegate         = delegate;
    button.countDownStrings = countDownStrings;
    [button setNormalString:normalString];
    
    return button;
}

- (void)dealloc {
    
    [self.button removeObserver:self forKeyPath:@"highlighted"];
}

@end
