//
//  PhoneNumChain.m
//  Animations
//
//  Created by YouXianMing on 2017/11/28.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "PhoneNumChain.h"
#import "RegexManager.h"

@implementation PhoneNumChain

- (ResponsibilityMessage *)canPassThrough {
    
    UITextField           *field   = self.object;
    ResponsibilityMessage *message = [ResponsibilityMessage new];
    message.object                 = self.object;
    message.checkSuccess           = YES;
    
    if (field.text.length <= 0) {
        
        message.errorMessage = @"手机号不能为空";
        message.checkSuccess = NO;
        
    } else if ([field.text existWithRegexPattern:@"\\d{11}|\\d{13}"] == NO) {
        
        message.errorMessage = @"手机号码不正确,请重新输入";
        message.checkSuccess = NO;
    }
    
    return message;
}

@end
