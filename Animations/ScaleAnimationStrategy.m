//
//  ScaleAnimationStrategy.m
//  Animations
//
//  Created by YouXianMing on 16/2/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ScaleAnimationStrategy.h"
#import "UIView+AnimationProperty.h"

@implementation ScaleAnimationStrategy

- (void)startAnimation {
    
    if (self.imageView) {
        
        self.imageView.scale = 0.85;
        self.imageView.alpha = 0.f;
        [UIView animateWithDuration:0.35 animations:^{
            
            self.imageView.scale = 1.f;
            self.imageView.alpha = 1.f;
        }];
    }
}

@end
