//
//  CountDownButton.h
//  PictureBooks
//
//  Created by YouXianMing on 2017/7/4.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CountDownButton;

@protocol CountDownButtonDelegate <NSObject>

/**
 CountDownButton被点击了

 @param button CountDownButton实体
 */
- (void)countDownButtonDidTaped:(CountDownButton *)button;

@end

@interface CountDownButton : UIView

/**
 代理
 */
@property (nonatomic, weak) id <CountDownButtonDelegate> delegate;

/**
 倒计时小时的文本数组(此字符串必须给,不然会导致崩溃)
 */
@property (nonatomic, strong) NSArray  *countDownStrings;

/**
 开始倒计时,需要手动调用(countDownStrings数组中的元素遍历完之后自动执行reset操作)
 */
- (void)start;

/**
 重置倒计时
 */
- (void)reset;

/**
 [- 子类重写 -] 设置没有倒计时时显示的文本

 @param normalString 没有倒计时的时候显示的文本
 */
- (void)setNormalString:(id)normalString;

/**
 [- 子类重写 -] 倒计时的文本内容

 @param string 文本内容
 */
- (void)countDownEventWithString:(id)string;

/**
 [- 子类重写 -] 对nomalContentView与countDownContentView进行配置

 @param normalContentView 用来添加倒计时开始之前显示的相关view
 @param countDownContentView 用来添加倒计时时的view
 */
- (void)configNomalContentView:(UIView *)normalContentView countDownContentView:(UIView *)countDownContentView;

/**
 [- 子类重写 -] 是否是高亮状态

 @param highlighted 是否是高亮状态
 */
- (void)isHighlighted:(BOOL)highlighted;

/**
 便利构造器

 @param frame Frame
 @param delegate Delegate
 @param countDownStrings Strings数组
 @param normalString 普通模式显示的字符串
 @return CountDownButton实体
 */
+ (instancetype)countDownButtonWithFrame:(CGRect)frame
                                delegate:(id <CountDownButtonDelegate>)delegate
                        countDownStrings:(NSArray *)countDownStrings
                            normalString:(id)normalString;

@end
