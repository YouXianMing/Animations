//
//  AbsTextFieldViewValidator.m
//  UITextField
//
//  Created by YouXianMing on 16/7/23.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AbsTextFieldViewValidator.h"

@implementation AbsTextFieldViewValidator

- (TextFieldValidatorMessage *)validatorWithInputSting:(NSString *)inputString {
    
   return textFieldValidatorMessageIsValid(YES, nil);
}

@end
