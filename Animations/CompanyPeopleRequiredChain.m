//
//  CompanyPeopleRequiredChain.m
//  Animations
//
//  Created by YouXianMing on 2017/11/28.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "CompanyPeopleRequiredChain.h"
#import "RegexManager.h"

@implementation CompanyPeopleRequiredChain

- (ResponsibilityMessage *)canPassThrough {
    
    UITextField           *field   = self.object;
    ResponsibilityMessage *message = [ResponsibilityMessage new];
    message.object                 = self.object;
    message.checkSuccess           = YES;
    
    if (field.text.length <= 0) {
        
        message.errorMessage = @"需求工位数不能为空";
        message.checkSuccess = NO;
        
    } else if ([field.text existWithRegexPattern:@"^[1-9]\\d*$"] == NO) {
        
        message.errorMessage = @"需求工位数有误,请重新输入";
        message.checkSuccess = NO;
    }
    
    return message;
}

@end
