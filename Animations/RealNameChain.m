//
//  RealNameChain.m
//  Animations
//
//  Created by YouXianMing on 2017/11/28.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "RealNameChain.h"

@implementation RealNameChain

- (ResponsibilityMessage *)canPassThrough {
    
    UITextField           *field   = self.object;
    ResponsibilityMessage *message = [ResponsibilityMessage new];
    message.object                 = self.object;
    message.checkSuccess           = YES;
    
    if (field.text.length <= 0) {
        
        message.errorMessage = @"用户名不能为空";
        message.checkSuccess = NO;
    }
    
    return message;
}

@end
