//
//  DrawValues.h
//  DrawWave
//
//  Created by YouXianMing on 15/12/5.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrawValues : NSObject

/**
 *  Value array's capacity.
 */
@property (nonatomic)                   NSInteger        valueCapacity;

/**
 *  Middle value.
 */
@property (nonatomic)                   CGFloat          middleValue;

/**
 *  Value's array.
 */
@property (nonatomic, strong, readonly) NSMutableArray  *values;

/**
 *  Create values.
 */
- (void)buildValues;

/**
 *  Add a value at last position & remove the first value.
 *
 *  @param value value.
 */
- (void)addValue:(NSNumber *)value;

@end
