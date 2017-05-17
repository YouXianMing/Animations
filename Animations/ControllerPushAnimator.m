//
//  ControllerPushAnimator.m
//  Animations
//
//  Created by YouXianMing on 2016/12/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ControllerPushAnimator.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"
#import "AnimationsListController.h"

@implementation ControllerPushAnimator

- (void)transitionAnimation {
    
    // http://stackoverflow.com/questions/25588617/ios-8-screen-blank-after-dismissing-view-controller-with-custom-presentation
    [self.containerView addSubview:self.toViewController.view];
    
    AnimationsListController *controller = (AnimationsListController *)self.fromViewController;
    
    self.toViewController.view.x = Width;
    [UIView animateWithDuration:self.transitionDuration - 0.1f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        controller.view.alpha        = 0.f;
        self.toViewController.view.x = 0;
        
    } completion:^(BOOL finished) {
        
        controller.view.alpha = 1.f;
        [self completeTransition];
    }];
}

@end
