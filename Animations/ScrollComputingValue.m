//
//  ScrollComputingValue.m
//  Animations
//
//  Created by YouXianMing on 16/3/13.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ScrollComputingValue.h"
#import "Math.h"

@interface ScrollComputingValue ()

@property (nonatomic, strong) Math    *frontLine;
@property (nonatomic, strong) Math    *backLine;
@property (nonatomic)         CGFloat  outputValue;

@end

@implementation ScrollComputingValue

- (void)makeTheSetupEffective {

    self.frontLine = [Math mathOnceLinearEquationWithPointA:MATHPointMake(self.startValue, 0) PointB:MATHPointMake(self.midValue, 1)];
    self.backLine  = [Math mathOnceLinearEquationWithPointA:MATHPointMake(self.midValue, 1) PointB:MATHPointMake(self.endValue, 0)];
}

@synthesize inputValue = _inputValue;

- (void)setInputValue:(CGFloat)inputValue {

    _inputValue = inputValue;
    
    if (inputValue <= _startValue) {
        
        _outputValue = 0;
        
    } else if (inputValue <= _midValue) {
        
        _outputValue = _frontLine.k * inputValue + _frontLine.b;
        
    } else if (inputValue <= _endValue) {
        
        _outputValue = _backLine.k * inputValue + _backLine.b;
        
    } else {
        
        _outputValue = 0;
    }
}

@end
