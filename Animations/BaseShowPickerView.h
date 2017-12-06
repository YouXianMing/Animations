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

@optional
- (void)baseShowPickerViewWillShow:(BaseShowPickerView *)showPickerView;
- (void)baseShowPickerViewDidShow:(BaseShowPickerView *)showPickerView;
- (void)baseShowPickerViewWillHide:(BaseShowPickerView *)showPickerView;
- (void)baseShowPickerViewDidHide:(BaseShowPickerView *)showPickerView;
- (void)baseShowPickerView:(BaseShowPickerView *)showPickerView didSelectedIndexs:(NSArray <NSNumber *> *)indexs items:(NSArray *)items;

@end

@interface BaseShowPickerView : UIView

@property (nonatomic, class, readonly)  CGFloat  contentViewHeight; // contentView的高度,需要子类提供数据

@property (nonatomic, weak)   id                               picker;       // 由子类在buildViewsInContentView中赋值,在configPicker中使用
@property (nonatomic, weak)   id                               object;       // weak对象
@property (nonatomic, weak)   id <BaseShowPickerViewDelegate>  delegate;     // 代理
@property (nonatomic, strong) id                               info;         // 信息数据
@property (nonatomic, strong) id                               selectedItem; // 选中内容,可能是数组,可能是一个对象
@property (nonatomic, strong) NSArray                         *showDatas;    // 显示内容的数据

+ (instancetype)showPickerViewWithDelegate:(id <BaseShowPickerViewDelegate>)delegate
                                       tag:(NSInteger)tag
                                    object:(id)object
                                      info:(id)info
                              selectedItem:(id)selectedItem
                                 showDatas:(NSArray *)showDatas;

/**
 在执行此方法之前,需要先提供contentViewHeight的数值
 */
- (void)prepare;

/**
 [子类重载] 在contentView中添加内容
 */
- (void)buildViewsInContentView:(UIView *)contentView;

/**
 [子类重载] 对picker进行配置以及数据的处理
 */
- (void)configPicker;

/**
 在keyWindow中显示
 */
- (void)showInKeyWindow;

/**
 在keyWindow中隐藏
 */
- (void)hideFromKeyWindow;

#pragma mark - Chain Programming.

+ (instancetype)build;
- (BaseShowPickerView *(^)(NSInteger tag))withTag;
- (BaseShowPickerView *(^)(id object))withObject;
- (BaseShowPickerView *(^)(id <BaseShowPickerViewDelegate> delegate))withDelegate;
- (BaseShowPickerView *(^)(id info))withInfo;
- (BaseShowPickerView *(^)(id selectedItem))withSelectedItem;
- (BaseShowPickerView *(^)(NSArray *showDatas))withShowDatas;
- (BaseShowPickerView *(^)(void))prepareAndShowInKeyWindow;

@end
