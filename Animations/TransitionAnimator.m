//
//  TransitionAnimator.m
//  Animator
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TransitionAnimator.h"

@interface TransitionAnimator ()

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, weak) UIViewController  *fromViewController;
@property (nonatomic, weak) UIViewController  *toViewController;
@property (nonatomic, weak) UIView            *containerView;

@end

@implementation TransitionAnimator

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.transitionDuration = 0.5f;
    }
    
    return self;
}

- (void)transitionAnimation {

    [NSException raise:@"TransitionAnimator Error."
                format:@"You should overwrite this method in subclass."];
}

- (void)completeTransition {

    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

#pragma mark - Protocol UIViewControllerAnimatedTransitioning.

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {

    return self.transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView      = [transitionContext containerView];
    self.transitionContext  = transitionContext;
    
    [self transitionAnimation];
}

- (void)animationEnded:(BOOL) transitionCompleted {

    if (self.delegate && [self.delegate respondsToSelector:@selector(transitionAnimationEnded:)]) {
        
        [self.delegate transitionAnimationEnded:self];
    }
}

@end
