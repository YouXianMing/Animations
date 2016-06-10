//
//  BadgeValueView.h
//  BadgeView
//
//  Created by YouXianMing on 16/5/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BadgePosition) {
    
    BadgePositionCenterLeft,
    BadgePositionCenterRight,
    
    BadgePositionTopLeft,
    BadgePositionTopRight,
    
    BadgePositionBottomLeft,
    BadgePositionBottomRight,
};

@interface BadgeValueView : UIView

/**
 *  bedge值
 */
@property (nonatomic, strong) NSString  *badgeValue;

/**
 *  被附着的view
 */
@property (nonatomic, weak)   UIView    *contentView;

/**
 *  敏感字符增长宽度,默认值为4
 */
@property (nonatomic)  CGFloat        sensitiveTextWidth;

/**
 *  敏感增长宽度,默认为10
 */
@property (nonatomic)  CGFloat        sensitiveWidth;

/**
 *  固定高度,默认为20
 */
@property (nonatomic)  CGFloat        fixedHeight;

/**
 *  位置信息,默认为BadgePositionTopRight
 */
@property (nonatomic)  BadgePosition  position;

/**
 *  字体,默认为12
 */
@property (nonatomic, strong) UIFont    *font;

/**
 *  字体颜色,默认为白色
 */
@property (nonatomic, strong) UIColor   *textColor;

/**
 *  bedge颜色,默认为红色
 */
@property (nonatomic, strong) UIColor   *badgeColor;

/**
 *  开始生效
 */
- (void)makeEffect;

/**
 *  设置BadgeValue
 *
 *  @param value    BadgeValue
 *  @param animated 是否执行动画
 */
- (void)setBadgeValue:(NSString *)value animated:(BOOL)animated;

@end
