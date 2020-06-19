//
//  ShimmeringView_1_Config.m
//  Animations
//
//  Created by YouXianMing on 2020/6/19.
//  Copyright © 2020 YouXianMing. All rights reserved.
//

#import "ShimmeringView_1_Config.h"

@implementation ShimmeringView_1_Config

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.shimmeringDirection         = FBShimmerDirectionDown;
        self.shimmeringSpeed             = 400.f;
        self.shimmeringOpacity           = 0.2;
        self.shimmeringAnimationOpacity  = 0.28;
        self.shimmeringHighlightLength   = 0.5f;
        self.shimmeringBeginFadeDuration = 0.f;
    }
    
    return self;
}

@end
