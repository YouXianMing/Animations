//
//  UITextFieldView.h
//  UITextField
//
//  Created by YouXianMing on 16/7/22.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbsTextFieldViewValidator.h"
@class UITextFieldView;

@protocol UITextFieldViewDelegate <NSObject>

@optional

/**
 *  When change characters in range, you can get the current string.
 *
 *  @param textFieldView UITextFieldView's object.
 *  @param currentString The current string.
 */
- (void)textFieldView:(UITextFieldView *)textFieldView currentString:(NSString *)currentString;

@end

/**
 *  Asks the delegate if editing should begin in the specified text field.
 *
 *  @param textFieldView UITextFieldView object.
 *
 *  @return YES if editing should begin or NO if it should not.
 */
typedef BOOL (^textFieldShouldBeginEditing_t)(UITextFieldView *textFieldView);

/**
 *  Tells the delegate that editing began in the specified text field.
 *
 *  @param textFieldView UITextFieldView object.
 */
typedef void (^textFieldDidBeginEditing_t)(UITextFieldView *textFieldView);

/**
 *  Asks the delegate if editing should stop in the specified text field.
 *
 *  @param textFieldView UITextFieldView object.
 *
 *  @return YES if editing should stop or NO if it should continue.
 */
typedef BOOL (^textFieldShouldEndEditing_t)(UITextFieldView *textFieldView);

/**
 *  Tells the delegate that editing stopped for the specified text field.
 *
 *  @param textFieldView UITextFieldView object.
 */
typedef void (^textFieldDidEndEditing_t)(UITextFieldView *textFieldView);

/**
 *  Asks the delegate if the specified text should be changed.
 *
 *  @param textFieldView     UITextFieldView object.
 *  @param range             The range of characters to be replaced.
 *  @param replacementString The replacement string for the specified range. During typing, this parameter normally contains only the single new character that was typed, but it may contain more characters if the user is pasting text. When the user deletes one or more characters, the replacement string is empty.
 *  @param currentText       The current string.
 *
 *  @return YES if the specified text range should be replaced; otherwise, NO to keep the old text.
 */
typedef BOOL (^textFieldshouldChangeCharactersInRange_t)(UITextFieldView *textFieldView, NSRange range, NSString *replacementString, NSString *currentText);

/**
 *  Asks the delegate if the text field’s current contents should be removed.
 *
 *  @param textFieldView UITextFieldView object.
 *
 *  @return YES if the text field’s contents should be cleared; otherwise, NO.
 */
typedef BOOL (^textFieldShouldClear_t)(UITextFieldView *textFieldView);

/**
 *  Asks the delegate if the text field should process the pressing of the return button.
 *
 *  @param textFieldView YES if the text field should implement its default behavior for the return button; otherwise, NO.
 *
 *  @return UITextFieldView object.
 */
typedef BOOL (^textFieldShouldReturn_t)(UITextFieldView *textFieldView);

#pragma mark - UITextFieldView

@interface UITextFieldView : UIView

/**
 *  UITextFieldView's delegate.
 */
@property (nonatomic, weak) id <UITextFieldViewDelegate> delegate;

/**
 *  To set the textField's text & currentText's text.
 *
 *  @param text The text you set.
 */
- (void)setCurrentTextFieldText:(NSString *)text;

/**
 *  The textField, you can use it to set many properties.
 */
@property (nonatomic, strong, readonly) UITextField *textField;

/**
 *  The current string.
 */
@property (nonatomic, strong, readonly) NSString *currentText;

#pragma mark - TextField validator.

/**
 *  TextField validator.
 */
@property (nonatomic, strong) AbsTextFieldViewValidator *textFieldViewValidator;

/**
 *  Checking the textField's string.
 *
 *  @return TextField validator message.
 */
- (TextFieldValidatorMessage *)checkingTheTextFieldViewString;

#pragma mark - TextField delegate's block. 

/**
 *  Should begin editing block.
 */
@property (nonatomic, copy) textFieldShouldBeginEditing_t shouldBeginEditingBlock;

/**
 *  Did begin editing block.
 */
@property (nonatomic, copy) textFieldDidBeginEditing_t didBeginEditingBlock;

/**
 *  should end editing block.
 */
@property (nonatomic, copy) textFieldShouldEndEditing_t shouldEndEditingBlock;

/**
 *  Did end editing block.
 */
@property (nonatomic, copy) textFieldDidEndEditing_t didEndEditingBlock;

/**
 *  Should change characters in range block.
 */
@property (nonatomic, copy) textFieldshouldChangeCharactersInRange_t shouldChangeCharactersInRangeBlock;

/**
 *  Should clear block.
 */
@property (nonatomic, copy) textFieldShouldClear_t shouldClearBlock;

/**
 *  Should return block.
 */
@property (nonatomic, copy) textFieldShouldReturn_t shouldReturnBlock;

/**
 *  Convenient method to set blocks.
 *
 *  @param changeCharactersInRange Should change characters in range block.
 *  @param didBeginEditingBlock    Did begin editing block.
 *  @param didEndEditingBlock      Did end editing block.
 *  @param shouldReturnBlock       Did end editing block.
 */
- (void)registerShouldChangeCharactersInRange:(textFieldshouldChangeCharactersInRange_t)changeCharactersInRange
                              didBeginEditing:(textFieldDidBeginEditing_t)didBeginEditingBlock
                                didEndEditing:(textFieldDidEndEditing_t)didEndEditingBlock
                                 shouldReturn:(textFieldShouldReturn_t)shouldReturnBlock;

#pragma mark - Become & resign first responder.

/**
 *  Notifies the receiver that it is about to become first responder in its window.
 */
- (void)becomeFirstResponder;

/**
 *  Notifies the receiver that it has been asked to relinquish its status as first responder in its window.
 */
- (void)resignFirstResponder;

#pragma mark - InputAccessoryView.

/**
 *  Create the inputAccessoryView.
 *
 *  @param height The inputAccessoryView's height that you specified.
 *  @param block  The block that you can use to add views on inputAccessoryView.
 */
- (void)createInputAccessoryViewWithViewHeight:(CGFloat)height block:(void (^)(UIView *inputAccessoryView, UITextFieldView *textFieldView))block;

#pragma mark - Transform position.

/**
 *  Rect from the view.
 *
 *  @param view The view you specified.
 *
 *  @return The rect.
 */
- (CGRect)rectFromView:(UIView *)view;

@end



