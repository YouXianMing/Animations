//
//  UIImage+Blend.h
//  BlendImage
//
//  Created by YouXianMing on 2017/12/20.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blend)

- (UIImage *)blendImage:(UIImage *)blendImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

@end
