//
//  SDWebImageAnimationStrategy.m
//  Animations
//
//  Created by YouXianMing on 16/2/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SDWebImageAnimationStrategy.h"

@implementation SDWebImageAnimationStrategy

- (void)startAnimation {
    
    if (_imageView) {
        
        CATransition *transition  = [CATransition animation];
        transition.type           = kCATransitionFade; // there are other types but this is the nicest
        transition.duration       = 0.34;              // set the duration that you like
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [_imageView.layer addAnimation:transition forKey:nil];
    }
}

@end
