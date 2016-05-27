//
//  TransitionAnimator.h
//  Animator
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class TransitionAnimator;

@protocol TransitionAnimatorDelegate <NSObject>

@optional

- (void)transitionAnimationEnded:(TransitionAnimator *)animator;

@end

@interface TransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

/**
 *  TransitionAnimator's delegate.
 */
@property (nonatomic, weak) id <TransitionAnimatorDelegate>  delegate;

/**
 *  Transition's duration, default value is 0.5f.
 */
@property (nonatomic) NSTimeInterval  transitionDuration;

/**
 *  Complete the transition.
 */
- (void)completeTransition;

#pragma mark - Overwrite by subClass.

/**
 *  Transition animation.
 */
- (void)transitionAnimation;

#pragma mark - Used in the method transitionAnimation.

/**
 *  Soure ViewController, used in method 'transitionAnimation'.
 */
@property (nonatomic, readonly, weak) UIViewController *fromViewController;

/**
 *  To ViewController, usde in method 'transitionAnimation'.
 */
@property (nonatomic, readonly, weak) UIViewController *toViewController;

/**
 *  The containerView.
 */
@property (nonatomic, readonly, weak) UIView           *containerView;

@end
