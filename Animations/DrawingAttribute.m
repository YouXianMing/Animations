//
//  DrawingAttribute.m
//  CGContext
//
//  Created by YouXianMing on 2017/8/23.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "DrawingAttribute.h"

@implementation DrawingAttribute

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.lineWidth   = 1.f;
        self.lineCap     = kCGLineCapButt;
        self.lineJoin    = kCGLineJoinRound;
        self.fillColor   = [UIColor grayColor];
        self.strokeColor = [UIColor blackColor];
    }
    
    return self;
}

@end
