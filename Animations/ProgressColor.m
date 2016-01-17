//
//  ProgressColor.m
//  Animations
//
//  Created by YouXianMing on 16/1/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ProgressColor.h"

@implementation ProgressColor

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.startPoint = CGPointMake(0.f, 0.5f);
        self.endPoint   = CGPointMake(1.f, 0.5f);
        self.duration   = 0.1f;
        
        NSMutableArray *cgColors = [NSMutableArray array];
        for (NSInteger deg = 0; deg <= 360; deg += 5) {
            
            UIColor *color = [UIColor colorWithHue:1.0 * deg / 360.0 saturation:1.0 brightness:1.0 alpha:1.0];
            [cgColors addObject:(id)[color CGColor]];
        }

        self.colors = [NSMutableArray arrayWithArray:cgColors];
    }
    
    return self;
}

- (NSArray *)loopMove {

    NSMutableArray *mutable = [_colors mutableCopy];
    
    id last = [mutable lastObject];
    [mutable removeLastObject];
    [mutable insertObject:last atIndex:0];
    
    NSArray *colors = [NSArray arrayWithArray:mutable];
    
    return colors;
}

@end
