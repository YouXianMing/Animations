//
//  DismissAnimator.m
//  Animator
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "DismissAnimator.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"

@implementation DismissAnimator

- (void)transitionAnimation {
    
    [UIView animateWithDuration:self.transitionDuration animations:^{
        
        self.toViewController.view.scale = 1.f;
        self.fromViewController.view.y   = Height;
        
    } completion:^(BOOL finished) {
        
        [self completeTransition];
    }];
}

@end
