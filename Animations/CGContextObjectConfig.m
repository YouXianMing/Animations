//
//  CGContextObjectConfig.m
//  CGContextObject
//
//  Created by YouXianMing on 15/11/12.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "CGContextObjectConfig.h"

@implementation CGContextObjectConfig

- (instancetype)init {
    
    if (self = [super init]) {
    
        _lineCap     = kCGLineCapButt;
        _lineJoin    = kCGLineJoinRound;
        _lineWidth   = 1.f;
        _strokeColor = [RGBColor colorWithUIColor:[UIColor blackColor]];
        _fillColor   = [RGBColor colorWithUIColor:[UIColor grayColor]];
        
        _phase   = 0;
        _lengths = nil;
        _count   = 0;
    }
    
    return self;
}

@end
