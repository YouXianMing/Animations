//
//  UIColor+ForPublicUse.m
//  Animations
//
//  Created by YouXianMing on 2016/11/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIColor+ForPublicUse.h"
#import "HexColors.h"

@implementation UIColor (ForPublicUse)

+ (UIColor *)backgroundColor {

    return [UIColor colorWithHexString:@"F7F7F7"];
}

+ (UIColor *)lineColor {

    return [UIColor colorWithHexString:@"E8E8E8"];
}

@end
