//
//  UITextFieldView.m
//  UITextField
//
//  Created by YouXianMing on 16/7/22.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UITextFieldView.h"

@interface UITextFieldView () <UITextFieldDelegate>

@property (nonatomic, strong) NSString    *currentText;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic)         BOOL         secureTextEntryBecomeActive;

@end

@implementation UITextFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.textField              = [[UITextField alloc] initWithFrame:self.bounds];
        self.textField.delegate     = self;
        self.textFieldViewValidator = [AbsTextFieldViewValidator new];
        [self addSubview:self.textField];
    }
    
    return self;
}

- (void)becomeFirstResponder {
    
    [self.textField becomeFirstResponder];
}

- (void)resignFirstResponder {
    
    [self.textField resignFirstResponder];
}

- (void)registerShouldChangeCharactersInRange:(textFieldshouldChangeCharactersInRange_t)block
                              didBeginEditing:(textFieldDidBeginEditing_t)didBeginEditingBlock
                                didEndEditing:(textFieldDidEndEditing_t)didEndEditingBlock
                                 shouldReturn:(textFieldShouldReturn_t)shouldReturnBlock {
    
    self.shouldChangeCharactersInRangeBlock = block;
    self.shouldReturnBlock                  = shouldReturnBlock;
    self.didBeginEditingBlock               = didBeginEditingBlock;
    self.didEndEditingBlock                 = didEndEditingBlock;
}

- (void)setCurrentTextFieldText:(NSString *)text {
    
    _currentText    = text;
    _textField.text = text;
}

- (void)createInputAccessoryViewWithViewHeight:(CGFloat)height block:(void (^)(UIView *inputAccessoryView, UITextFieldView *textFieldView))block {
    
    CGRect rect                       = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    self.textField.inputAccessoryView = [[UIView alloc] initWithFrame:rect];
    block ? block(self.textField.inputAccessoryView, self) : 0;
}

- (TextFieldValidatorMessage *)checkingTheTextFieldViewString {
    
    return [self.textFieldViewValidator validatorWithInputSting:self.currentText];
}

- (CGRect)rectFromView:(UIView *)view {
    
    return [self convertRect:self.bounds toView:view];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (self.shouldBeginEditingBlock) {
        
        return self.shouldBeginEditingBlock(self);
        
    } else {
        
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.didBeginEditingBlock) {
        
        self.didBeginEditingBlock(self);
    }
    
    if (self.textField.secureTextEntry == YES) {
        
        _secureTextEntryBecomeActive = YES;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (self.shouldEndEditingBlock) {
        
        return self.shouldEndEditingBlock(self);
        
    } else {
        
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.didEndEditingBlock) {
        
        self.didEndEditingBlock(self);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.textField.secureTextEntry == YES && _secureTextEntryBecomeActive == YES) {
        
        // 密码键盘特殊处理
        self.currentText                 = [NSMutableString stringWithString:string.length <= 0 ? @"" : string];
        self.secureTextEntryBecomeActive = NO;
        
    } else {
        
        // 普通键盘
        NSString *currentText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        self.currentText      = currentText;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldView:currentString:)]) {
        
        [self.delegate textFieldView:self currentString:self.currentText];
    }
    
    if (self.shouldChangeCharactersInRangeBlock) {
        
        return self.shouldChangeCharactersInRangeBlock(self, range, string, self.currentText);
        
    } else {
        
        return YES;
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if (self.shouldClearBlock) {
        
        return self.shouldClearBlock(self);
        
    } else {
        
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (self.shouldReturnBlock) {
        
        return self.shouldReturnBlock(self);
        
    } else {
        
        return YES;
    }
}

- (void)dealloc {
    
    self.shouldBeginEditingBlock            = nil;
    self.didBeginEditingBlock               = nil;
    self.shouldEndEditingBlock              = nil;
    self.didEndEditingBlock                 = nil;
    self.shouldChangeCharactersInRangeBlock = nil;
    self.shouldClearBlock                   = nil;
    self.shouldReturnBlock                  = nil;
}

@end
