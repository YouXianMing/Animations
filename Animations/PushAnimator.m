//
//  PushAnimator.m
//  Animator
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PushAnimator.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"
#import "AnimationsListViewController.h"

@implementation PushAnimator

- (void)transitionAnimation {
    
    // http://stackoverflow.com/questions/25588617/ios-8-screen-blank-after-dismissing-view-controller-with-custom-presentation
    [self.containerView addSubview:self.toViewController.view];
    
    AnimationsListViewController *controller = (AnimationsListViewController *)self.fromViewController;
    
    self.toViewController.view.x = Width;
    [UIView animateWithDuration:self.transitionDuration - 0.1f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        controller.view.alpha        = 0.f;
        self.toViewController.view.x = 0;
        
    } completion:^(BOOL finished) {
        
        [self completeTransition];
    }];
}

@end
