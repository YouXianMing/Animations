//
//  NSObject+ResponsibilityChain.m
//  Animations
//
//  Created by YouXianMing on 2017/11/1.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "NSObject+ResponsibilityChain.h"
#import <objc/runtime.h>

@implementation NSObject (ResponsibilityChain)

- (void)setResponsibilityChain:(ResponsibilityChain *)responsibilityChain {
    
    responsibilityChain.object = self;
    objc_setAssociatedObject(self, @selector(responsibilityChain), responsibilityChain, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ResponsibilityChain *)responsibilityChain {
    
    return objc_getAssociatedObject(self, _cmd);
}

@end
