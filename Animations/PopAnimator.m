//
//  PopAnimator.m
//  Animator
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PopAnimator.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"
#import "AnimationsListViewController.h"

@implementation PopAnimator

- (void)transitionAnimation {
    
    // http://stackoverflow.com/questions/25513300/using-custom-ios-7-transition-with-subclassed-uinavigationcontroller-occasionall
    [self.containerView insertSubview:self.toViewController.view belowSubview:self.fromViewController.view];

    AnimationsListViewController *controller = (AnimationsListViewController *)self.toViewController;
    
    [UIView animateWithDuration:self.transitionDuration - 0.1 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        controller.view.alpha          = 1.f;
        self.fromViewController.view.x = Width;
        
    } completion:^(BOOL finished) {
        
        [self completeTransition];
    }];
}

@end
