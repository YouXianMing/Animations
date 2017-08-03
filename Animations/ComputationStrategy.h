//
//  ComputationStrategy.h
//  MathematicalComputation
//
//  Created by YouXianMing on 2017/8/3.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Math.h"

@interface ComputationStrategy : NSObject

/**
 The function to compute new value with input value.

 @param value The input value.
 @return The new value.
 */
- (CGFloat)functionWithValue:(CGFloat)value;

@end
