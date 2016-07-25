//
//  AbsTextFieldViewValidator.h
//  UITextField
//
//  Created by YouXianMing on 16/7/23.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextFieldValidatorMessage.h"

@interface AbsTextFieldViewValidator : NSObject

- (TextFieldValidatorMessage *)validatorWithInputSting:(NSString *)inputString;

@end
