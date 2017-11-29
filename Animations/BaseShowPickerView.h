//
//  BaseShowPickerView.h
//  Animations
//
//  Created by YouXianMing on 2017/11/29.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseShowPickerView;

@protocol BaseShowPickerViewDelegate <NSObject>

- (void)baseShowPickerViewWillShow:(BaseShowPickerView *)showPickerView;
- (void)baseShowPickerViewDidShow:(BaseShowPickerView *)showPickerView;
- (void)baseShowPickerViewWillHide:(BaseShowPickerView *)showPickerView;
- (void)baseShowPickerViewDidHide:(BaseShowPickerView *)showPickerView;
- (void)baseShowPickerView:(BaseShowPickerView *)showPickerView didSelectedIndexs:(NSArray <NSNumber *> *)indexs items:(NSArray *)items;

@end

@interface BaseShowPickerView : UIView

/**
 用来添加显示内容的contentView
 */
@property (nonatomic, strong, readonly) UIView  *contentView;
@property (nonatomic, class, readonly)  CGFloat  contentViewHeight;

@property (nonatomic, weak)   id                               object;
@property (nonatomic, weak)   id <BaseShowPickerViewDelegate>  delegate;
@property (nonatomic, strong) id                               info;
@property (nonatomic, strong) id                               selectedItem;
@property (nonatomic, strong) NSArray                         *showDatas;

/**
 在设置之前,需要先设置好contentView的高度值(contentViewHeight的设定)
 */
- (void)setup;

- (void)showInKeyWindow;
- (void)hideFromKeyWindow;

/**
 由子类重载后在contentView中添加内容
 */
- (void)addViewsInContentView;

@end
