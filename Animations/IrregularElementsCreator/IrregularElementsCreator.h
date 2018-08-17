//
//  IrregularElementsCreator.h
//  IrregularElementsCreator
//
//  Created by YouXianMing on 2018/8/17.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IrregularElementsCreator : NSObject

#pragma mark - 配置参数

/**
 是否从右往左排序(默认值为NO)
 */
@property (nonatomic) BOOL isRightToLeft;

/**
 是否是从下往上排序(默认值为NO)
 */
@property (nonatomic) BOOL isBottomToTop;

/**
 区域宽度
 */
@property (nonatomic) CGFloat areaWidth;

/**
 上下左右边距
 */
@property (nonatomic) UIEdgeInsets edgeInsets;

/**
 元素间水平方向的间隙
 */
@property (nonatomic) CGFloat itemHorizontalGap;

/**
 元素间垂直方向的间隙
 */
@property (nonatomic) CGFloat itemVerticalGap;

/**
 元素的高度
 */
@property (nonatomic) CGFloat itemHeight;

/**
 元素宽度的数组
 */
@property (nonatomic, strong) NSArray <NSNumber *> *itemWidths;

#pragma mark - 计算与取值

/**
 开始计算所有元素的frame值
 */
- (void)startCreateElementsFrames;

/**
 区域宽度(在startCreateElementsFrames调用之后才能够获取到)
 */
@property (nonatomic, readonly) CGFloat areaHeight;

/**
 对应的每个元素的frame值(在startCreateElementsFrames调用之后才能够获取到)
 */
@property (nonatomic, strong, readonly) NSArray <NSValue *> *itemFrames;

#pragma mark - 便利方法

+ (instancetype)irregularElementsCreatorWithItemIsRightToLeft:(BOOL)isRightToLeft
                                                isBottomToTop:(BOOL)isBottomToTop
                                                    areaWidth:(CGFloat)areaWidth
                                                   edgeInsets:(UIEdgeInsets)edgeInsets
                                            itemHorizontalGap:(CGFloat)itemHorizontalGap
                                              itemVerticalGap:(CGFloat)itemVerticalGap
                                                   itemHeight:(CGFloat)itemHeight
                                                   itemWidths:(NSArray <NSNumber *> *)itemWidths;

+ (void)irregularElementsCreatorWithItemIsRightToLeft:(BOOL)isRightToLeft
                                        isBottomToTop:(BOOL)isBottomToTop
                                            areaWidth:(CGFloat)areaWidth
                                           edgeInsets:(UIEdgeInsets)edgeInsets
                                    itemHorizontalGap:(CGFloat)itemHorizontalGap
                                      itemVerticalGap:(CGFloat)itemVerticalGap
                                           itemHeight:(CGFloat)itemHeight
                                           itemWidths:(NSArray <NSNumber *> *)itemWidths
                                              results:(void (^)(CGFloat areaHeight, NSArray <NSValue *> *itemFrames))results;
@end

