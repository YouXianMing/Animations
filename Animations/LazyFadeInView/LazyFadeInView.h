//
//  LazyFadeInView.h
//  LazyFadeInView
//
//  Created by Tu You on 14-4-20.
//  Copyright (c) 2014年 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LazyFadeIn.h"

@class LazyFadeInView;

@protocol LazyFadeInViewDelegate <NSObject>

@optional
- (void)fadeInAnimationDidEnd:(LazyFadeInView *)fadeInView;

@end

@interface LazyFadeInView : UIView<LazyFadeIn>

@property (weak, nonatomic) id<LazyFadeInViewDelegate> delegate;

@end
