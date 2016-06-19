//
//  UILabel+FrameAndTag.m
//  SetRect
//
//  Created by YouXianMing on 16/6/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UILabel+FrameAndTag.h"

@implementation UILabel (FrameAndTag)

+ (instancetype)oneLineLeftAlignmentLabelInsertIntoView:(UIView *)view
                                                    tag:(NSInteger)tag
                                             attachedTo:(id <AccessViewTagProtocol>)object
                                                   text:(NSString *)text
                                                   font:(UIFont *)font
                                              textColor:(UIColor *)color
                                             setupBlock:(ViewSetupBlock)block {
    
    UILabel *label      = [[UILabel alloc] initWithFrame:view.bounds];
    [object setView:label withTag:tag];
    label.text          = text;
    label.numberOfLines = 1;
    label.font          = font;
    label.textColor     = color;
    [view addSubview:label];
    
    if (block) {
        
        block(label);
    }
    
    return label;
}

+ (instancetype)oneLineRightAlignmentLabelInsertIntoView:(UIView *)view
                                                     tag:(NSInteger)tag
                                              attachedTo:(id <AccessViewTagProtocol>)object
                                                    text:(NSString *)text
                                                    font:(UIFont *)font
                                               textColor:(UIColor *)color
                                              setupBlock:(ViewSetupBlock)block {
    
    UILabel *label      = [[UILabel alloc] initWithFrame:view.bounds];
    [object setView:label withTag:tag];
    label.text          = text;
    label.numberOfLines = 1;
    label.font          = font;
    label.textAlignment = NSTextAlignmentRight;
    label.textColor     = color;
    [view addSubview:label];
    
    if (block) {
        
        block(label);
    }
    
    return label;
}

+ (instancetype)oneLineCenterAlignmentLabelInsertIntoView:(UIView *)view
                                                positionY:(CGFloat)positionY
                                                   height:(CGFloat)height
                                                      tag:(NSInteger)tag
                                               attachedTo:(id <AccessViewTagProtocol>)object
                                                     text:(NSString *)text
                                                     font:(UIFont *)font
                                                textColor:(UIColor *)color
                                               setupBlock:(ViewSetupBlock)block {
    
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, positionY, view.frame.size.width, height)];
    [object setView:label withTag:tag];
    label.text          = text;
    label.numberOfLines = 1;
    label.font          = font;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = color;
    [view addSubview:label];
    
    if (block) {
        
        block(label);
    }
    
    return label;
}

+ (instancetype)oneLineCenterAlignmentLabelInsertIntoView:(UIView *)view
                                                positionY:(CGFloat)positionY
                                                   height:(CGFloat)height
                                                     text:(NSString *)text
                                                     font:(UIFont *)font
                                                textColor:(UIColor *)color
                                               setupBlock:(ViewSetupBlock)block {
    
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, positionY, view.frame.size.width, height)];
    label.text          = text;
    label.numberOfLines = 1;
    label.font          = font;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = color;
    [view addSubview:label];
    
    if (block) {
        
        block(label);
    }
    
    return label;
}

+ (instancetype)oneLineLeftAlignmentLabelInsertIntoView:(UIView *)view
                                                   text:(NSString *)text
                                                   font:(UIFont *)font
                                              textColor:(UIColor *)color
                                             setupBlock:(ViewSetupBlock)block {
    
    UILabel *label      = [[UILabel alloc] initWithFrame:view.bounds];
    label.text          = text;
    label.numberOfLines = 1;
    label.font          = font;
    label.textColor     = color;
    [view addSubview:label];
    
    if (block) {
        
        block(label);
    }
    
    return label;
}

+ (instancetype)oneLineRightAlignmentLabelInsertIntoView:(UIView *)view
                                                    text:(NSString *)text
                                                    font:(UIFont *)font
                                               textColor:(UIColor *)color
                                              setupBlock:(ViewSetupBlock)block {
    
    UILabel *label      = [[UILabel alloc] initWithFrame:view.bounds];
    label.text          = text;
    label.numberOfLines = 1;
    label.font          = font;
    label.textAlignment = NSTextAlignmentRight;
    label.textColor     = color;
    [view addSubview:label];
    
    if (block) {
        
        block(label);
    }
    
    return label;
}

@end
