//
//  DrawingStyle.m
//  DrawRectObject
//
//  Created by YouXianMing on 16/7/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "DrawingStyle.h"

@implementation DrawingStyle

- (instancetype)init {
    
    if (self = [super init]) {
        
        _lineCap     = kCGLineCapButt;
        _lineJoin    = kCGLineJoinRound;
        _lineWidth   = 1.f;
        _strokeColor = [DrawingColor colorWithUIColor:[UIColor blackColor]];
        _fillColor   = [DrawingColor colorWithUIColor:[UIColor grayColor]];
        
        _phase   = 0;
        _lengths = nil;
        _count   = 0;
    }
    
    return self;
}

@end
