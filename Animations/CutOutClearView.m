//
//  CutOutClearView.m
//  Animations
//
//  Created by YouXianMing on 16/7/10.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CutOutClearView.h"

@implementation CutOutClearView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.fillColor       = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
        self.opaque          = NO;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [self.fillColor setFill];
    UIRectFill(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
 
    if (self.areaColor && self.paths.count) {
        
        UIBezierPath *path = nil;
        
        for (int i = 0; i < self.paths.count; i++) {
            
            i == 0 ? path = self.paths[i] : [path appendPath:self.paths[i]];
        }
        
        CGFloat red   = 0;
        CGFloat green = 0;
        CGFloat blue  = 0;
        CGFloat alpha = 0;
        [self.areaColor getRed:&red green:&green blue:&blue alpha:&alpha];
        
        CGContextAddPath(context, path.CGPath);
        CGContextSetRGBFillColor(context, red, green, blue, alpha);
        CGContextFillPath(context);
        
    } else {
    
        for (UIBezierPath *path in self.paths) {
            
            CGContextAddPath(context, path.CGPath);
            CGContextSetBlendMode(context, kCGBlendModeClear);
            CGContextFillPath(context);
        }
    }
}

@end
