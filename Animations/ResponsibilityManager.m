//
//  ResponsibilityManager.m
//  Animations
//
//  Created by YouXianMing on 2017/11/1.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "ResponsibilityManager.h"

@interface ResponsibilityManager ()

@property (nonatomic, strong) NSMutableArray *storeChains;

@end

@implementation ResponsibilityManager

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.storeChains = [NSMutableArray array];
    }
    
    return self;
}

- (NSArray *)chains {
    
    return [NSArray arrayWithArray:self.storeChains];
}

- (void)addChain:(NSObject *)object {

    NSParameterAssert(object.responsibilityChain);
    [self.storeChains addObject:object];
}

- (void)removeChain:(NSObject *)object {
    
    NSParameterAssert(object.responsibilityChain);
    [self.storeChains removeObject:object];
}

- (ResponsibilityMessage *)checkResponsibilityChain {
   
    ResponsibilityMessage *message = nil;
    
    for (NSObject *chain in self.storeChains) {
     
        message = [chain.responsibilityChain canPassThrough];
        if (message.checkSuccess == NO) {
            
            break;
        }
    }
    
    return message;
}

@end
