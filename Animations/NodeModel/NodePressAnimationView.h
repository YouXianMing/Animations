//
//  NodePressAnimationView.h
//  YoCelsius
//
//  Created by YouXianMing on 15/11/12.
//  Copyright © 2015年 XianMingYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NodePressAnimationView;

@protocol NodePressAnimationViewDelegate <NSObject>

- (void)nodePressAnimationViewCompleteEventWithView:(NodePressAnimationView *)animationView;

@end

@interface NodePressAnimationView : UIView

@property (nonatomic, strong) UIFont   *font;
@property (nonatomic, strong) NSString *text;


@property (nonatomic, strong) UIColor  *normalTextColor;
@property (nonatomic, strong) UIColor  *highlightTextColor;


@property (nonatomic, strong) UIColor  *animationColor;
@property (nonatomic)         CGFloat   animationWidth;


@property (nonatomic, weak)   id<NodePressAnimationViewDelegate>  delegate; 


/**
 *  动画结束 + 恢复正常的时间
 */
@property (nonatomic) CGFloat toEndDuration;
@property (nonatomic) CGFloat toNormalDuration;

@end
