//
//  ScrollComputingValue.h
//  Animations
//
//  Created by YouXianMing on 16/3/13.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*  
              midValue
 
                 /\
                /  \
               /    \
              /      \
             /        \
            /          \
           /            \
     ------              ------
          |              |
      startValue      endValue
 */

@interface ScrollComputingValue : NSObject

@property (nonatomic)           CGFloat  startValue;
@property (nonatomic)           CGFloat  midValue;
@property (nonatomic)           CGFloat  endValue;

/**
 *  The input value.
 */
@property (nonatomic)           CGFloat  inputValue;

/**
 *  The output value is in range [0, 1].
 */
@property (nonatomic, readonly) CGFloat  outputValue;

/**
 *  Make the setup effective.
 */
- (void)makeTheSetupEffective;

@end
