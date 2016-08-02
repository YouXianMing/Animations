//
//  WaveView.m
//  DrawRectObject
//
//  Created by YouXianMing on 16/8/1.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "WaveView.h"

@implementation WaveView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.waveCrest = 10.f;
        self.waveCount = 1;
        self.phase     = 0.f;
        self.type      = kFillWave;
        
        DrawingStyle *fillStyle = [DrawingStyle new];
        fillStyle.fillColor     = [DrawingColor colorWithUIColor:[[UIColor redColor] colorWithAlphaComponent:0.5f]];
        self.fillStyle          = fillStyle;
        
        DrawingStyle *strokeStyle = [DrawingStyle new];
        strokeStyle.strokeColor   = [DrawingColor colorWithUIColor:[UIColor redColor]];
        strokeStyle.lineWidth     = 0.5f;
        self.strokeStyle          = strokeStyle;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    NSParameterAssert(self.fillStyle);
    NSParameterAssert(self.strokeStyle);

    [super drawRect:rect];
    
    CGFloat width  = self.frame.size.width;
    CGFloat height = self.frame.size.height;

    if (self.type & kFillWave) {
        
        [self.drawRectObject useDrawingStyle:_fillStyle drawFillBlock:^(DrawRectObject *drawRectObject) {
            
            for (CGFloat x = 0; x <= width; x++) {
                
                if (x == 0) {
                    
                    [drawRectObject moveToStartPoint:CGPointMake(x, _waveCrest * sin((2 * M_PI) * _waveCount / width * x + _phase) + height / 2.f)];
                    continue;
                    
                } else {
                    
                    [drawRectObject addLineToPoint:CGPointMake(x, _waveCrest * sin((2 * M_PI) * _waveCount / width * x + _phase) + height / 2.f)];
                }
            }
            
            [drawRectObject addLineToPoint:CGPointMake(width, height)];
            [drawRectObject addLineToPoint:CGPointMake(0, height)];
            [drawRectObject addLineToPoint:CGPointMake(0, _waveCrest * sin((2 * M_PI) * _waveCount / width * 0 + _phase) + height / 2.f)];
        }];
    }
    
    if (self.type & kStrokeWave) {
        
        [self.drawRectObject useDrawingStyle:_strokeStyle drawStrokeBlock:^(DrawRectObject *drawRectObject) {
            
            for (CGFloat x = 0; x <= width; x++) {
                
                if (x == 0) {
                    
                    [drawRectObject moveToStartPoint:CGPointMake(x, _waveCrest * sin((2 * M_PI) * _waveCount / width * x + _phase) + height / 2.f)];
                    continue;
                    
                } else {
                    
                    [drawRectObject addLineToPoint:CGPointMake(x, _waveCrest * sin((2 * M_PI) * _waveCount / width * x + _phase) + height / 2.f)];
                }
            }
        }];
    }
}

@end
