//
//  BaseControl.m
//  BaseButton
//
//  Created by YouXianMing on 15/8/27.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "BaseControl.h"

@interface BaseControl ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation BaseControl

- (void)layoutSubviews {

    [super layoutSubviews];
    
    _button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self baseControlSetup];
    }
    
    return self;
}

- (void)baseControlSetup {
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_button];
    
    // 开始点击
    [_button addTarget:self action:@selector(touchBegin) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    
    // 拖拽到rect外面
    [_button addTarget:self action:@selector(touchDragExit) forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchCancel];
    
    // 触发事件
    [_button addTarget:self action:@selector(touchEvent) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchEvent {
    
    [NSException raise:NSInternalInconsistencyException
                format:@"对不起,您不能直接调用 '%@ %d' 中的方法 '%@',您需要通过继承其子类,在子类中重载该方法",
     [NSString stringWithUTF8String:__FILE__].lastPathComponent, __LINE__, NSStringFromSelector(_cmd)];
}

- (void)touchDragExit {
    
    [NSException raise:NSInternalInconsistencyException
                format:@"对不起,您不能直接调用 '%@ %d' 中的方法 '%@',您需要通过继承其子类,在子类中重载该方法",
     [NSString stringWithUTF8String:__FILE__].lastPathComponent, __LINE__, NSStringFromSelector(_cmd)];
}

- (void)touchBegin {
    
    [NSException raise:NSInternalInconsistencyException
                format:@"对不起,您不能直接调用 '%@ %d' 中的方法 '%@',您需要通过继承其子类,在子类中重载该方法",
     [NSString stringWithUTF8String:__FILE__].lastPathComponent, __LINE__, NSStringFromSelector(_cmd)];
}

#pragma mark - setter & getter.

- (void)setEnabled:(BOOL)enabled {
    
    _enabled        = enabled;
    _button.enabled = enabled;
}

@end
