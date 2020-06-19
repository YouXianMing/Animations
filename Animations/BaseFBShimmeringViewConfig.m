//
//  BaseFBShimmeringViewConfig.m
//  AjMall
//
//  Created by YouXianMing on 2020/6/17.
//  Copyright © 2020 YouXianMing. All rights reserved.
//

#import "BaseFBShimmeringViewConfig.h"

@implementation BaseFBShimmeringViewConfig

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.shimmeringPauseDuration     = 0.4f;
        self.shimmeringAnimationOpacity  = 1.f;
        self.shimmeringOpacity           = 0.5f;
        self.shimmeringSpeed             = 230.f;
        self.shimmeringHighlightLength   = 0.33;
        self.shimmeringDirection         = FBShimmerDirectionRight;
        self.shimmeringBeginFadeDuration = 0.1f;
        self.shimmeringEndFadeDuration   = 0.3f;
    }
    
    return self;
}

@end
