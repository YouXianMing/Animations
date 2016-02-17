//
//  UIView+AnimationPracticalMethod.m
//  ZiPeiYi
//
//  Created by YouXianMing on 16/2/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIView+AnimationPracticalMethod.h"

@implementation UIView (AnimationPracticalMethod)

- (void)alpha:(CGFloat)alpha duration:(NSTimeInterval)duration animated:(BOOL)animated {

    CGFloat effectiveAlpha = (alpha < 0 || alpha > 1) ? (alpha < 0 ? 0 : 1) : alpha;
    
    if (animated) {
        
        [UIView animateWithDuration:effectiveAlpha animations:^{
            
            self.alpha = alpha;
        }];
        
    } else {
    
        self.alpha = alpha;
    }
}

@end
