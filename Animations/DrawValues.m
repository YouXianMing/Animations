//
//  DrawValues.m
//  DrawWave
//
//  Created by YouXianMing on 15/12/5.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "DrawValues.h"

@interface DrawValues ()

@property (nonatomic, strong) NSMutableArray  *values;
@property (nonatomic)         CGFloat          multiplier;

@end

@implementation DrawValues

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.multiplier = -1.f;
    }
    
    return self;
}

- (void)buildValues {

    self.values = [NSMutableArray arrayWithCapacity:self.valueCapacity];
    
    for (int i = 0; i < _valueCapacity; i++) {
        
        [self.values addObject:@(_middleValue)];
    }
}

- (void)addValue:(NSNumber *)value {

    self.multiplier   *= -1;
    CGFloat storeValue = value.floatValue * self.multiplier;
    
    [self.values removeObjectAtIndex:0];
    [self.values addObject:@(self.middleValue + storeValue)];
}

@end
