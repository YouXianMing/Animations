//
//  LazyFadeInLayer.h
//  LazyFadeInView
//
//  Created by Tu You on 14-4-20.
//  Copyright (c) 2014年 Tu You. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LazyFadeIn.h"

@interface LazyFadeInLayer : CATextLayer <LazyFadeIn>

@property (weak, nonatomic) UIView *sourceView;

@end
