//
//  UIImage+SolidColor.m
//  BaseButton
//
//  Created by YouXianMing on 16/1/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIImage+SolidColor.h"

@implementation UIImage (SolidColor)

+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color {
    
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
