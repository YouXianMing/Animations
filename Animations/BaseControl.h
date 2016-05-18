//
//  BaseControl.h
//  BaseButton
//
//  Created by YouXianMing on 15/8/27.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseControl;

@protocol BaseControlDelegate <NSObject>

@optional

/**
 *  点击事件触发
 *
 *  @param control BaseControl对象
 */
- (void)baseControlTouchEvent:(BaseControl *)control;

@end

@interface BaseControl : UIView

/**
 *  代理方法
 */
@property (nonatomic, weak) id <BaseControlDelegate>  delegate;

#pragma mark - 以下方法需要子类重载

/**
 *  触发了点击事件
 */
- (void)touchEvent;

/**
 *  拖拽到rect外面触发的事件
 */
- (void)touchDragExit;

/**
 *  点击事件开始
 */
- (void)touchBegin;

@end
