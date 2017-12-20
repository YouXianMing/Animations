//
//  UIImage+Blend.m
//  BlendImage
//
//  Created by YouXianMing on 2017/12/20.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "UIImage+Blend.h"

@implementation UIImage (Blend)

- (UIImage *)blendImage:(UIImage *)blendImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha {
    
    CGSize newSize = [self size];
    CGRect rect    = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContext(newSize);
    [self       drawInRect:rect blendMode:kCGBlendModeNormal alpha:1];
    [blendImage drawInRect:rect blendMode:blendMode          alpha:alpha];
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
