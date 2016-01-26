//
//  AbstractAdapter.h
//  Animations
//
//  Created by YouXianMing on 16/1/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractAdapter : NSObject

/**
 *  Input data.
 */
@property (nonatomic, weak) id inputData;

/**
 *  Output data.
 */
@property (nonatomic, weak, readonly) id outputData;

/**
 *  Start data transform.
 */
- (void)startDataTransform;

/**
 *  Get the output data by inputData.
 *
 *  @param inputData Input data.
 *
 *  @return Output data.
 */
+ (id)abstractAdapterWithInputData:(id)inputData;

@end
