//
//  AbstractAdapter.m
//  Animations
//
//  Created by YouXianMing on 16/1/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AbstractAdapter.h"

@interface AbstractAdapter ()

@property (nonatomic, weak) id  outputData;

@end

@implementation AbstractAdapter

- (void)startDataTransform {

    self.outputData = self.inputData;
}

+ (id)abstractAdapterWithInputData:(id)inputData {

    AbstractAdapter *adapter = [AbstractAdapter new];
    
    adapter.inputData = inputData;
    [adapter startDataTransform];
    
    return adapter.outputData;
}

@end
