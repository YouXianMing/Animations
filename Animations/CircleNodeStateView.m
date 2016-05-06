//
//  CircleNodeStateView.m
//  Animations
//
//  Created by YouXianMing on 16/5/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CircleNodeStateView.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"

@interface CircleNodeStateView ()

@property (nonatomic, strong) UIView  *colorView;

@end

@implementation CircleNodeStateView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.colorView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 3)];
        self.colorView.layer.cornerRadius  = self.colorView.width / 2.f;
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
        
        self.colorView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.25f];
        self.colorView.scale           = 1.f;
        
    } else {
        
        self.colorView.backgroundColor = [UIColor cyanColor];
        self.colorView.scale           = 1.75f;
    }
}

@end
