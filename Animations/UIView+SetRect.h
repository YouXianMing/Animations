//
//  UIView+SetRect.h
//  UIView
//
//  Created by YouXianMing on 16/1/29.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIScreen width.
 */
#define  Width   [UIScreen mainScreen].bounds.size.width

/**
 *  UIScreen height.
 */
#define  Height  [UIScreen mainScreen].bounds.size.height

/**
 *  Status bar height.
 */
#define  StatusBarHeight      20.f

/**
 *  Navigation bar height.
 */
#define  NavigationBarHeight  44.f

/**
 *  Tabbar height.
 */
#define  TabbarHeight         49.f

/**
 *  Status bar & navigation bar height.
 */
#define  StatusBarAndNavigationBarHeight   (20.f + 44.f)

/**
 *  iPhone4 or iPhone4s
 */
#define  iPhone4_4s     (Width == 320.f && Height == 480.f ? YES : NO)

/**
 *  iPhone5 or iPhone5s
 */
#define  iPhone5_5s     (Width == 320.f && Height == 568.f ? YES : NO)

/**
 *  iPhone6 or iPhone6s
 */
#define  iPhone6_6s     (Width == 375.f && Height == 667.f ? YES : NO)

/**
 *  iPhone6Plus or iPhone6sPlus
 */
#define  iPhone6_6sPlus (Width == 414.f && Height == 736.f ? YES : NO)

@interface UIView (SetRect)

/*----------------------
 * Absolute coordinate *
 ----------------------*/

@property (nonatomic) CGPoint viewOrigin;
@property (nonatomic) CGSize  viewSize;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

/*----------------------
 * Relative coordinate *
 ----------------------*/

@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint middlePoint;

@end
