//
//  DrawGradientColorView.m
//  CGContextObject
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "DrawGradientColorView.h"
#import "CGContextObject.h"
#import "GradientColor.h"

@interface DrawGradientColorView ()

@property (nonatomic, strong)  CGContextObject  *contextObject;

@end

@implementation DrawGradientColorView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    _contextObject = [[CGContextObject alloc] initWithCGContext:UIGraphicsGetCurrentContext()
                                                         config:[CGContextObjectConfig new]];
    
    {
        size_t  count             = 3;
        CGFloat locations[]       = {0.0, 0.5, 1.0};
        CGFloat colorComponents[] = {
            //red, green, blue, alpha
            0.254, 0.599, 0.82,  1.0,
            0.192, 0.525, 0.75,  1.0,
            0.096, 0.415, 0.686, 1.0};
        
        GradientColor *gradientColor = [GradientColor gradientColorWithLocations:locations
                                                                      components:colorComponents
                                                                           count:count];
        
        [_contextObject drawLinearGradientAtClipToRect:CGRectMake(0, 0, 10, self.frame.size.height)
                                         gradientColor:gradientColor
                                            startPoint:CGPointMake(0, 0)
                                              endPoint:CGPointMake(0, self.frame.size.height)];
    }
    
    {
        size_t  count             = 4;
        CGFloat locations[]       = {0.0, 0.3, 0.7, 1.0};
        CGFloat colorComponents[] = {
            //red, green, blue, alpha
            [self randomValue], [self randomValue], [self randomValue],  1.0,
            [self randomValue], [self randomValue], [self randomValue],  1.0,
            [self randomValue], [self randomValue], [self randomValue],  1.0,
            [self randomValue], [self randomValue], [self randomValue], 1.0};
        
        GradientColor *gradientColor = [GradientColor gradientColorWithLocations:locations
                                                                      components:colorComponents
                                                                           count:count];
        
        [_contextObject drawLinearGradientAtClipToRect:CGRectMake(20, 0, 10, self.frame.size.height)
                                         gradientColor:gradientColor
                                            startPoint:CGPointMake(0, 0)
                                              endPoint:CGPointMake(0, self.frame.size.height)];
    }
}

- (CGFloat)randomValue {

    CGFloat value = arc4random() % 101 / 100.f;
    return value;
}

@end
