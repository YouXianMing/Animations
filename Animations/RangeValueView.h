//
//  RangeValueView.h
//  POPSpring
//
//  Created by YouXianMing on 15/5/14.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RangeValueView : UIView

/**
 *  文本标签
 */
@property (nonatomic, strong)   NSString  *text;

/**
 *  一些值的设置
 */
@property (nonatomic)           CGFloat    minValue;
@property (nonatomic)           CGFloat    maxValue;
@property (nonatomic, readonly) CGFloat    currentValue;
@property (nonatomic)           CGFloat    defaultValue;

/**
 *  便利构造器创建出视图
 *
 *  @param frame        控件的尺寸
 *  @param name         控件名字
 *  @param minValue     最小值
 *  @param maxValue     最大值
 *  @param defaultValue 默认值
 *
 *  @return 视图对象
 */
+ (instancetype)rangeValueViewWithFrame:(CGRect)frame
                                   name:(NSString *)name
                               minValue:(CGFloat)minValue
                               maxValue:(CGFloat)maxValue
                           defaultValue:(CGFloat)defaultValue;

@end
