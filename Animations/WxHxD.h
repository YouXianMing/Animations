//
//  WxHxD.h
//  ZiPeiYi
//
//  Created by YouXianMing on 15/12/9.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/////////////////////////  USE THIS  /////////////////////////

#define Width                 [WxHxD width]
#define Height                [WxHxD height]
#define iPhone                [WxHxD iPhoneType]
#define StatusBarHeight       20.f  // Status bar height.
#define NavigationBarHeight   44.f  // Navigation bar height.
#define TabbarHeight          49.f  // Tab bar height.

//////////////////////////////////////////////////////////////

typedef enum : NSUInteger {
    
    unKnow = 0x9,
    
    iPhone4_4s,
    iPhone5_5s,
    iPhone6,
    iPhone6_plus,
    
} EiPhoneType;

@interface WxHxD : NSObject

/**
 *  Base setup, you should run this method at 
 */
+ (void)setup;

/**
 *  Get current iPhone type.
 *
 *  @return iPhone type.
 */
+ (EiPhoneType)iPhoneType;

/**
 *  Screen's width.
 *
 *  @return Width.
 */
+ (CGFloat)width;

/**
 *  Screen's height.
 *
 *  @return Height.
 */
+ (CGFloat)height;

@end
