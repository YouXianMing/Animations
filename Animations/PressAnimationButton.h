//
//  PressAnimationButton.h
//  Animations
//
//  Created by YouXianMing on 16/1/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PressAnimationButton;

@protocol PressAnimationButtonDelegate <NSObject>

@optional

/**
 *  Finished event by PressAnimationButton.
 *
 *  @param button PressAnimationButton.
 */
- (void)finishedEventByPressAnimationButton:(PressAnimationButton *)button;

@end

@interface PressAnimationButton : UIView

/**
 *  PressAnimationButton's delegate.
 */
@property (nonatomic, weak)   id        <PressAnimationButtonDelegate>  delegate;

@property (nonatomic, strong) UIFont   *font;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) UIColor  *normalTextColor;
@property (nonatomic, strong) UIColor  *highlightTextColor;

@property (nonatomic, strong) UIColor  *animationColor;

/**
 *  Animation's width.
 */
@property (nonatomic)         CGFloat   animationWidth;

/**
 *  动画结束 + 恢复正常的时间
 */
@property (nonatomic) CGFloat toEndDuration;
@property (nonatomic) CGFloat toNormalDuration;


@end
