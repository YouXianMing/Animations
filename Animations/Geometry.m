//
//  Geometry.m
//  ZiPeiYi
//
//  Created by YouXianMing on 16/1/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "Geometry.h"

@implementation Geometry

+ (CGSize)resetFromSize:(CGSize)size withFixedWidth:(CGFloat)width {

    CGFloat newHeight = size.height * (width / size.width);
    CGSize  newSize   = CGSizeMake(width, newHeight);
    
    return newSize;
}

+ (CGSize)resetFromSize:(CGSize)size withFixedHeight:(CGFloat)height {

    float  newWidth = size.width * (height / size.height);
    CGSize newSize  = CGSizeMake(newWidth, height);
    
    return newSize;
}

@end
