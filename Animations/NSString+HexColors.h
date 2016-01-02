//
//  NSString+HexColors.h
//  HexColors
//
//  Created by YouXianMing on 15/9/15.
//  Copyright (c) 2015年 Reversebox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (HexColors)

/**
 *  hexColor
 *
 *  @"#ff8942" or @"ff8942" or @"fff"
 *
 *  @return 二进制的颜色
 */
- (UIColor *)hexColor;

@end
