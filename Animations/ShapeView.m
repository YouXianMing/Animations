//
//  ShapeView.m
//  TechCodeApplication
//
//  Created by YouXianMing on 16/6/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ShapeView.h"
#import "CGContextObject.h"

@interface ShapeView ()

@property (nonatomic, strong)  CGContextObject  *contextObject;

@end

@implementation ShapeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {

    if (self.points) {
        
        // Init CGContextObject.
        CGContextObjectConfig *config = [CGContextObjectConfig new];
        config.fillColor              = [RGBColor colorWithUIColor:self.fillColor ? self.fillColor : [UIColor whiteColor]];
        
        _contextObject = [[CGContextObject alloc] initWithCGContext:UIGraphicsGetCurrentContext() config:config];
        
        // Start draw.
        [_contextObject contextConfig:config drawFillBlock:^(CGContextObject *contextObject) {
            
            [contextObject addLinePoints:self.points];
        }];
    }
}

@end
