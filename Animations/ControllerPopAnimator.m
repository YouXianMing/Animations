//
//  ControllerPopAnimator.m
//  Animations
//
//  Created by YouXianMing on 2016/12/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ControllerPopAnimator.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationProperty.h"
#import "AnimationsListController.h"

@implementation ControllerPopAnimator

- (void)transitionAnimation {
    
    // http://stackoverflow.com/questions/25513300/using-custom-ios-7-transition-with-subclassed-uinavigationcontroller-occasionall
    [self.containerView insertSubview:self.toViewController.view belowSubview:self.fromViewController.view];
    
    AnimationsListController *controller = (AnimationsListController *)self.toViewController;
    
    [UIView animateWithDuration:self.transitionDuration - 0.1 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        controller.view.alpha          = 1.f;
        self.fromViewController.view.x = Width;
        
    } completion:^(BOOL finished) {
        
        [self completeTransition];
    }];
}

@end
