//
//  NSString+HexColors.m
//  HexColors
//
//  Created by YouXianMing on 15/9/15.
//  Copyright (c) 2015年 Reversebox. All rights reserved.
//

#import "NSString+HexColors.h"
#import "HexColors.h"

@implementation NSString (HexColors)

- (UIColor *)hexColor {

    UIColor *color = nil;
    
    if (self.length) {
        
        color = [HXColor colorWithHexString:self];
    }
    
    return color;
}

@end
