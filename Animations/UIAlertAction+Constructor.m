//
//  UIAlertAction+Constructor.m
//  TechCode
//
//  Created by YouXianMing on 16/7/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIAlertAction+Constructor.h"

@implementation UIAlertAction (Constructor)

+ (instancetype)defaultStyleActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))handler {

    return [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
}

+ (instancetype)cancelStyleActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))handler {
    
    return [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:handler];
}

+ (instancetype)destructiveStyleActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))handler {
    
    return [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:handler];
}

@end
