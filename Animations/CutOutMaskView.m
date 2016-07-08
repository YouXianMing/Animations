//
//  CutOutMaskView.m
//  Animations
//
//  Created by YouXianMing on 16/7/8.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CutOutMaskView.h"

@implementation CutOutMaskView

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [self.fillColor setFill];
    UIRectFill(rect);
    
    for (NSValue *value in self.framesToCutOut) {
        
        CGRect pathRect = [value CGRectValue];
        [[UIColor clearColor] setFill];
        UIRectFill(pathRect);
    }
}

- (void)makeEffective {

    self.backgroundColor = [UIColor clearColor];
    self.opaque          = NO;
}

@end
