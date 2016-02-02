//
//  RefreshObject.h
//  UIScrollView
//
//  Created by YouXianMing on 15/6/24.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RefreshObject;

typedef enum : NSUInteger {
    
    NORMAL_STATE,  // 正常状态
    REFRESH_STATE, // 刷新状态
    
} ERefreshState;

@protocol RefreshObjectDelegate <NSObject>

@required
/**
 *  开始刷新
 *
 *  @param refreshObject
 */
- (void)startRefreshing:(RefreshObject *)refreshObject;

/**
 *  结束刷新
 *
 *  @param refreshObject
 */
- (void)endRefresh:(RefreshObject *)refreshObject;

/**
 *  移动过程
 *
 *  @param refreshObject
 *  @param offset        偏移量
 *  @param percent       百分比
 */
- (void)moving:(RefreshObject *)refreshObject offset:(CGFloat)offset percent:(CGFloat)percent;

@end

@interface RefreshObject : NSObject

/**
 *  代理
 */
@property (nonatomic, weak)           id <RefreshObjectDelegate> delegate;

/**
 *  当前状态
 */
@property (nonatomic, readonly)       ERefreshState    state;
@property (nonatomic)                 CGFloat          height;
@property (nonatomic, weak, readonly) UIScrollView    *scrollView;

/**
 *  调用后开始刷新
 */
- (void)beginRefreshing;

/**
 *  调用后结束刷新
 */
- (void)endRefresh;

/**
 *  === 由子类调用 ===
 *
 *  更新刷新状态
 *
 *  @param state 刷新状态
 */
- (void)changeState:(ERefreshState)state;

#pragma mark - 如果要更新刷新效果,请子类重写该方法
/**
 *  === 子类可以重写该方法实现新的刷新效果 ===
 *
 *  刷新时候的动画
 */
- (void)refreshingAnimation;

/**
 *  === 子类可以重写该方法实现新的刷新效果 ===
 *
 *  结束刷新时候的动画
 */
- (void)endRefreshAnimation;

#pragma mark - 便利构造器

/**
 *  构造对象
 *
 *  @param height 高度
 *
 *  @return 对象
 */
+ (instancetype)refreshObjectWithHeight:(CGFloat)height;

#pragma mark - 不要调用的方法

/**
 *  === 请不要手动调用 ===
 *
 *  添加监听的对象
 *
 *  @param scrollView
 */
- (void)addObserverObject:(UIScrollView *)scrollView;

/**
 *  === 请不要手动调用 ===
 *
 *  添加监听
 */
- (void)addObserverWithScrollView;

/**
 *  === 请不要手动调用 ===
 *
 *  移除监听
 */
- (void)removeObserverWithScrollView;

@end
