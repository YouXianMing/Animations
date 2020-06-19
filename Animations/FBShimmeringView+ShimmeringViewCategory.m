//
//  FBShimmeringView+ShimmeringViewCategory.m
//  AjMall
//
//  Created by YouXianMing on 2020/6/17.
//  Copyright © 2020 YouXianMing. All rights reserved.
//

#import "FBShimmeringView+ShimmeringViewCategory.h"

@implementation FBShimmeringView (ShimmeringViewCategory)

- (FBShimmeringView *)startShimmering {
    
    self.shimmering = YES;
    return self;
}

- (FBShimmeringView *)stopShimmering {
    
    self.shimmering = NO;
    return self;
}

- (FBShimmeringView *)useConfig:(BaseFBShimmeringViewConfig *)config {
    
    BaseFBShimmeringViewConfig *tmp = config;
    
    if (config == nil) {
        
        tmp = BaseFBShimmeringViewConfig.new;
    }
    
    self.shimmeringPauseDuration     = tmp.shimmeringPauseDuration;
    self.shimmeringAnimationOpacity  = tmp.shimmeringAnimationOpacity;
    self.shimmeringOpacity           = tmp.shimmeringOpacity;
    self.shimmeringSpeed             = tmp.shimmeringSpeed;
    self.shimmeringHighlightLength   = tmp.shimmeringHighlightLength;
    self.shimmeringDirection         = tmp.shimmeringDirection;
    self.shimmeringBeginFadeDuration = tmp.shimmeringBeginFadeDuration;
    self.shimmeringEndFadeDuration   = tmp.shimmeringEndFadeDuration;
    
    return self;
}

@end
