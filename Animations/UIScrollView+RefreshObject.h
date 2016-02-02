//
//  UIScrollView+RefreshObject.h
//  UIScrollView
//
//  Created by YouXianMing on 15/6/24.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshObject.h"


@interface UIScrollView (RefreshObject)

/**
 *  需要主动赋值
 */
@property (nonatomic, strong, readonly)  RefreshObject  *refreshObject;

/**
 *  创建刷新对象并设置刷新对象代理
 *
 *  @param refreshObject 刷新对象
 *  @param delegate      刷新对象代理
 */
- (void)createRefreshObject:(RefreshObject *)refreshObject refreshObjectDelegate:(id)delegate;

/**
 *  移除刷新对象
 */
- (void)removeRefreshObject;

/**
 *  开始刷新
 */
- (void)beginRefresh;

/**
 *  结束刷新
 */
- (void)endRefresh;

@end
