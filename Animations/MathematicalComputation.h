//
//  MathematicalComputation.h
//  MathematicalComputation
//
//  Created by YouXianMing on 2017/8/3.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ComputationStrategy.h"

@interface MathematicalComputation : NSObject

/**
 The computation strategy.
 */
@property (nonatomic, strong) ComputationStrategy *strategy;

/**
 Get value Y with input value X.

 @param x The input value X.
 @return The result Y.
 */
- (CGFloat)getValue_Y_with_X:(CGFloat)x;

#pragma mark - Constructor

+ (instancetype)mathematicalComputationWithStrategy:(ComputationStrategy *)strategy;

@end
