//
//  DrawView.m
//  DrawWave
//
//  Created by YouXianMing on 15/12/5.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "DrawView.h"
#import "CGContextObject.h"
#import "DrawValues.h"
#import "UIView+SetRect.h"

@interface DrawView ()

@property (nonatomic, strong) CGContextObject *contextObject;
@property (nonatomic, strong) DrawValues      *drawValues;

@end

@implementation DrawView

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
    config.fillColor              = [RGBColor colorWithUIColor:[UIColor clearColor]];
    config.lineWidth              = 0.5f;
    config.lineCap                = kCGLineCapRound;
    config.lineJoin               = kCGLineJoinRound;
    
    _contextObject = [[CGContextObject alloc] initWithCGContext:UIGraphicsGetCurrentContext()
                                                         config:config];
    
    [self.drawValues addValue:[NSNumber numberWithFloat:(arc4random() % 41)]];
    
    [self.contextObject contextConfig:nil drawStrokeBlock:^(CGContextObject *contextObject) {
        
        for (int i = 0; i < _drawValues.values.count; i++) {
            
            NSNumber *value = _drawValues.values[i];
            
            if (i == 0) {
                
                [_contextObject moveToStartPoint:CGPointMake(i, value.floatValue)];
                
            } else {
            
                [_contextObject addLineToPoint:CGPointMake(i, value.floatValue)];
            }
        }
    }];
}

@end
