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
 *  目标
 */
@property (nonatomic, weak) id target;

/**
 *  控制事件
 */
@property (nonatomic) SEL   selector;

/**
 *  代理方法
 */
@property (nonatomic, weak) id <BaseControlDelegate>  delegate;

/**
 *  容器view
 */
@property (nonatomic, strong, readonly) UIView   *contentView;

/**
 *  是否有效
 */
@property (nonatomic) BOOL     enabled;

/**
 *  是否选中
 */
@property (nonatomic) BOOL     selected;

#pragma mark - 以下方法需要子类重载

/**
 *  触发了点击事件
 */
- (void)touchUpInside;

/**
 *  拖拽到rect外面或者取消了
 */
- (void)touchDragExitOrTouchCancel;

/**
 *  点击事件开始或者从外部拖拽进来
 */
- (void)touchBeginOrTouchDragEnter;

@end
