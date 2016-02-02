//
//  RefreshObjectAnimationProtocal.h
//  TableViewRefresh
//
//  Created by YouXianMing on 15/6/25.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RefreshObjectAnimationProtocal <NSObject>

@required

/**
 *  ==== 当为 100% 的时候, 该view的状态值需要与 startRefreshAnimation 中view执行动画的起始值一致 ====
 *
 *  根据百分比动态设置动画的值
 *
 *  @param percent 百分比
 */
- (void)animationWithPercent:(CGFloat)percent;

/**
 *  开始执行刷新动画
 */
- (void)startRefreshAnimation;

/**
 *  结束刷新动画
 */
- (void)endRefreshAnimation;

@end
