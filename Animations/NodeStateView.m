//
//  NodeStateView.m
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "NodeStateView.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"

@interface NodeStateView ()

@property (nonatomic, strong) UIView  *colorView;

@end

@implementation NodeStateView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.colorView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 16)];
        self.colorView.center              = self.middlePoint;
        self.colorView.layer.masksToBounds = YES;
        [self addSubview:self.colorView];
    }
    
    return self;
}

- (void)changeToState:(EInfiniteLoopNodeState)state animated:(BOOL)animated {
    
    if (animated) {
    
        [UIView animateWithDuration:0.5f animations:^{
            
            [self redViewWithState:state];
        }];
        
    } else {
    
        [self redViewWithState:state];
    }
}

- (void)redViewWithState:(EInfiniteLoopNodeState)state {

    if (state == kInfiniteLoopNormalState) {
        
        self.colorView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
    } else {
        
        self.colorView.backgroundColor = [UIColor redColor];
    }
}

@end
