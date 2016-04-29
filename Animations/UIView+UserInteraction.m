//
//  UIView+UserInteraction.m
//  TechCode
//
//  Created by YouXianMing on 16/4/29.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIView+UserInteraction.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) NSNumber  *userInteractionNumbers;

@end

@implementation UIView (UserInteraction)

- (void)enabledUserInteraction {
    
    [self accessUserInteractionNumbers];
    
    self.userInteractionNumbers = @(self.userInteractionNumbers.integerValue + 1);
    
    [self accessUserInteraction];
}

- (void)disableUserInteraction {
    
    [self accessUserInteractionNumbers];
    
    self.userInteractionNumbers = @(self.userInteractionNumbers.integerValue - 1);
    
    [self accessUserInteraction];
}

- (void)accessUserInteractionNumbers {
    
    if (self.userInteractionNumbers == nil) {
        
        self.userInteractionNumbers = @(0);
    }
}

- (void)accessUserInteraction {

    if (self.userInteractionNumbers.integerValue > 0) {
        
        self.userInteractionEnabled = YES;
        
    } else {
        
        self.userInteractionEnabled = NO;
    }
}

- (void)setUserInteractionNumbers:(NSNumber *)userInteractionNumbers {
    
    objc_setAssociatedObject(self, @selector(userInteractionNumbers), userInteractionNumbers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)userInteractionNumbers {
    
    return objc_getAssociatedObject(self, _cmd);
}

@end
