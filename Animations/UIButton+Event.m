//
//  UIButton+Event.m
//  RecordMusic
//
//  Created by YouXianMing on 16/7/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIButton+Event.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, copy) buttonEvent_t buttonEventBlock;

@end

@implementation UIButton (Event)

- (void)blockEvent:(buttonEvent_t)block {

    self.buttonEventBlock = block;
    
    if (self.buttonEventBlock) {
        
        [self addTarget:self action:@selector(blockTouchUpInSideEvent:) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
    
        [self removeTarget:self action:@selector(blockTouchUpInSideEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)blockTouchUpInSideEvent:(UIButton *)button {

    if (self.buttonEventBlock) {
        
        self.buttonEventBlock(button);
    }
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                  configBlock:(void (^)(UIButton *button))configBlock
                   eventBlock:(buttonEvent_t)eventBlock {

    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    configBlock ? configBlock(button) : 0;    
    [button blockEvent:eventBlock];
    
    return button;
}

#pragma mark - Setter & Getter.

- (void)setButtonEventBlock:(buttonEvent_t)buttonEventBlock {

    objc_setAssociatedObject(self, @selector(buttonEventBlock), buttonEventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (buttonEvent_t)buttonEventBlock {

    return objc_getAssociatedObject(self, _cmd);
}

@end
