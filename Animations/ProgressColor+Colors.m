//
//  ProgressColor+Colors.m
//  Animations
//
//  Created by YouXianMing on 16/1/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ProgressColor+Colors.h"

@implementation ProgressColor (Colors)

+ (ProgressColor *)redGradientColor {
    
    ProgressColor *color = [ProgressColor new];
    
    NSMutableArray *cgColors = [NSMutableArray array];
    
    [cgColors addObject:(id)[[UIColor colorWithRed:0.2f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.2f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.3f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.4f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.5f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.6f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.7f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.8f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.9f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.9f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.8f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.7f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.6f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.5f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.4f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.3f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.2f green:0.f blue:0.f alpha:1.f] CGColor]];
    [cgColors addObject:(id)[[UIColor colorWithRed:0.2f green:0.f blue:0.f alpha:1.f] CGColor]];
    
    color.colors   = cgColors;
    color.duration = 0.1f;
    
    return color;
}

@end
