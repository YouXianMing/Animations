//
//  DrawLineView.m
//  Animations
//
//  Created by YouXianMing on 15/12/5.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "DrawLineView.h"
#import "CGContextObject.h"
#import "DrawValues.h"
#import "UIView+SetRect.h"

@interface DrawLineView ()

@property (nonatomic, strong) CGContextObject *contextObject;
@property (nonatomic, strong) DrawValues      *drawValues;

@end

@implementation DrawLineView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.drawValues               = [DrawValues new];
        self.drawValues.valueCapacity = (NSInteger)Width;
        self.drawValues.middleValue   = 100.f;
        [self.drawValues buildValues];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextObjectConfig *config = [CGContextObjectConfig new];
    config.fillColor              = [RGBColor colorWithUIColor:[UIColor redColor]];
    config.strokeColor            = [RGBColor colorWithUIColor:[UIColor clearColor]];
    config.lineWidth              = 0.5f;
    config.lineCap                = kCGLineCapRound;
    
    _contextObject = [[CGContextObject alloc] initWithCGContext:UIGraphicsGetCurrentContext()
                                                         config:config];
    
    [self.drawValues addValue:[NSNumber numberWithFloat:(arc4random() % 41)]];
    
    [self.contextObject contextConfig:nil drawFillBlock:^(CGContextObject *contextObject) {
        
        [_contextObject addRectPath:CGRectMake(0, 100.f, Width, 0.5f)];
        
        for (int i = 0; i < _drawValues.values.count; i++) {
            
            NSNumber *value = _drawValues.values[i];
            CGFloat   tmp   = value.floatValue;
            
            if (tmp >= 100) {
                
                [_contextObject addRectPath:CGRectMake(i, 100, 1.f, tmp - 100)];
                
            } else {
            
                [_contextObject addRectPath:CGRectMake(i, tmp, 1.f, 100 - tmp)];
            }
        }
    }];
}

@end
