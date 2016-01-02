//
//  UIButton+inits.m
//  BaseController
//
//  Created by YouXianMing on 15/7/17.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "UIButton+inits.h"

@implementation UIButton (inits)

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag target:(id)target action:(SEL)selector {

    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:16.f];
    button.layer.borderWidth  = 1.f;
    button.layer.cornerRadius = 3.f;
    button.tag                = tag;

    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                         buttonType:(EButtonType)type
                              title:(NSString *)title
                                tag:(NSInteger)tag
                             target:(id)target
                             action:(SEL)selector {

    UIButton *button          = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font    = [UIFont fontWithName:@"Avenir-Book" size:16.f];
    button.layer.borderWidth  = 1.f;
    button.layer.cornerRadius = 3.f;
    button.tag                = tag;
    
    if (type == BUTTON_NORMAL) {
        
        button.layer.borderColor = [UIColor blackColor].CGColor;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
    } else if (type == BUTTON_RED) {
    
        button.layer.borderColor = [UIColor redColor].CGColor;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
    } else {
    
        button.layer.borderColor = [UIColor blackColor].CGColor;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


@end
