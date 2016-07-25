//
//  TextFieldValidatorMessage.h
//  ZiPeiYi
//
//  Created by YouXianMing on 16/1/8.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextFieldValidatorMessage : NSObject

/**
 *  Is valid string or not.
 */
@property (nonatomic) BOOL isValidString;

/**
 *  Error message.
 */
@property (nonatomic, strong) NSString *errorMessage;

/**
 *  Convenient method.
 *
 *  @param errorMessage  Error message string.
 *  @param isValidString Is valid string or not.
 *
 *  @return TextFieldValidatorMessage.
 */
+ (TextFieldValidatorMessage *)textFieldValidatorMessageWithErrorMessage:(NSString *)errorMessage
                                                           isValidString:(BOOL)isValidString;

@end

/**
 *  Convenient method.
 *
 *  @param isValidString Is valid string or not.
 *  @param errorMessage  Error message string.
 *
 *  @return TextFieldValidatorMessage.
 */
NS_INLINE TextFieldValidatorMessage * textFieldValidatorMessageIsValid(BOOL isValidString, NSString *errorMessage) {

    return [TextFieldValidatorMessage textFieldValidatorMessageWithErrorMessage:errorMessage
                                                                  isValidString:isValidString];
}

