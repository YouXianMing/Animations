//
//  BaseShowPickerView.m
//  Animations
//
//  Created by YouXianMing on 2017/11/29.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "BaseShowPickerView.h"

@interface BaseShowPickerView ()

@property (nonatomic, strong) UIView   *contentView;
@property (nonatomic, weak)   UIWindow *keyWindow;
@property (nonatomic, strong) UIButton *backgroundButton;

@end

@implementation BaseShowPickerView

- (void)prepare {
    
    // 获取keywindow
    NSParameterAssert([UIApplication sharedApplication].keyWindow);
    self.keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 创建背景的按钮
    self.frame                            = self.keyWindow.bounds;
    self.backgroundButton                 = [[UIButton alloc] initWithFrame:self.keyWindow.bounds];
    self.backgroundButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.f];
    [self.backgroundButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backgroundButton];
    
    // 创建contentView
    self.contentView                 = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                                self.keyWindow.frame.size.height,
                                                                                self.keyWindow.frame.size.width,
                                                                                [[self class] contentViewHeight])];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    
    // 在contentView里面添加显示的view
    [self buildViewsInContentView:self.contentView];
    
    // 对picker进行配置
    [self configPicker];
}

- (void)buildViewsInContentView:(UIView *)contentView {
    
    // Overwrite by subclass.
}

- (void)configPicker {
    
    // Overwrite by subclass.
}

+ (instancetype)showPickerViewWithDelegate:(id <BaseShowPickerViewDelegate>)delegate {
    
    BaseShowPickerView *pickerView = [[self class] new];
    pickerView.delegate            = delegate;
    
    return pickerView;
}

- (void)showInKeyWindow {
    
    [self.keyWindow addSubview:self];
    
    // 代理 - 将要显示
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseShowPickerViewWillShow:)]) {
    
        [self.delegate baseShowPickerViewWillShow:self];
    }
    
    [UIView animateWithDuration:0.35f animations:^{
        
        self.backgroundButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25f];
        self.contentView.frame                = CGRectMake(0,
                                                           self.keyWindow.frame.size.height - [[self class] contentViewHeight],
                                                           self.keyWindow.frame.size.width,
                                                           [[self class] contentViewHeight]);
        
    } completion:^(BOOL finished) {
        
        // 代理 - 已经显示
        if (self.delegate && [self.delegate respondsToSelector:@selector(baseShowPickerViewDidShow:)]) {
            
            [self.delegate baseShowPickerViewDidShow:self];
        }
    }];
}

- (void)hideFromKeyWindow {
    
    // 代理 - 将要消失
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseShowPickerViewWillHide:)]) {
        
        [self.delegate baseShowPickerViewWillHide:self];
    }
    
    [UIView animateWithDuration:0.35f animations:^{
        
        self.backgroundButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.f];
        self.contentView.frame                = CGRectMake(0,
                                                           self.keyWindow.frame.size.height,
                                                           self.keyWindow.frame.size.width,
                                                           [[self class] contentViewHeight]);
        
    } completion:^(BOOL finished) {
        
        // 代理 - 已经消失
        if (self.delegate && [self.delegate respondsToSelector:@selector(baseShowPickerViewDidHide:)]) {
            
            [self.delegate baseShowPickerViewDidHide:self];
        }
        
        self.keyWindow = nil;
        [self removeFromSuperview];
    }];
}

- (void)buttonEvent:(UIButton *)button {
    
    [self hideFromKeyWindow];
}

+ (CGFloat)contentViewHeight {
    
    return 0;
}

@end
