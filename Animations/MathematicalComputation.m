//
//  MathematicalComputation.m
//  MathematicalComputation
//
//  Created by YouXianMing on 2017/8/3.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "MathematicalComputation.h"

@implementation MathematicalComputation

- (instancetype)init {

    if (self = [super init]) {
    
        self.strategy = [ComputationStrategy new];
    }
    
    return self;
}

- (CGFloat)getValue_Y_with_X:(CGFloat)x {
    
    return [self.strategy functionWithValue:x];
}

+ (instancetype)mathematicalComputationWithStrategy:(ComputationStrategy *)strategy {
    
    MathematicalComputation *computation = [[self class] new];
    computation.strategy                 = strategy;
    
    return computation;
}

@end
