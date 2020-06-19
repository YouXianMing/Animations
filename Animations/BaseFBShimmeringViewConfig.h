//
//  BaseFBShimmeringViewConfig.h
//  AjMall
//
//  Created by YouXianMing on 2020/6/17.
//  Copyright © 2020 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBShimmering.h"

@interface BaseFBShimmeringViewConfig : NSObject

//! @abstract The time interval between shimmerings in seconds. Defaults to 0.4.
@property (assign, nonatomic, readwrite) CFTimeInterval shimmeringPauseDuration;

//! @abstract The opacity of the content while it is shimmering. Defaults to 1.0.
@property (assign, nonatomic, readwrite) CGFloat shimmeringAnimationOpacity;

//! @abstract The opacity of the content before it is shimmering. Defaults to 0.5.
@property (assign, nonatomic, readwrite) CGFloat shimmeringOpacity;

//! @abstract The speed of shimmering, in points per second. Defaults to 230.
@property (assign, nonatomic, readwrite) CGFloat shimmeringSpeed;

//! @abstract The highlight length of shimmering. Range of [0,1], defaults to 0.33.
@property (assign, nonatomic, readwrite) CGFloat shimmeringHighlightLength;

//! @abstract The direction of shimmering animation. Defaults to FBShimmerDirectionRight.
@property (assign, nonatomic, readwrite) FBShimmerDirection shimmeringDirection;

//! @abstract The duration of the fade used when shimmer begins. Defaults to 0.1.
@property (assign, nonatomic, readwrite) CFTimeInterval shimmeringBeginFadeDuration;

//! @abstract The duration of the fade used when shimmer ends. Defaults to 0.3.
@property (assign, nonatomic, readwrite) CFTimeInterval shimmeringEndFadeDuration;

@end
