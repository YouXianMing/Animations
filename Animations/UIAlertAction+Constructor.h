//
//  UIAlertAction+Constructor.h
//  TechCode
//
//  Created by YouXianMing on 16/7/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertAction (Constructor)

/**
 *  Default style action.
 *
 *  @param title   Title.
 *  @param handler Handler.
 *
 *  @return UIAlertAction's object.
 */
+ (instancetype)defaultStyleActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))handler;

/**
 *  Cancel style action.
 *
 *  @param title   Title.
 *  @param handler Handler.
 *
 *  @return UIAlertAction's object.
 */
+ (instancetype)cancelStyleActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))handler;

/**
 *  Destructive style action.
 *
 *  @param title   Title.
 *  @param handler Handler.
 *
 *  @return UIAlertAction's object.
 */
+ (instancetype)destructiveStyleActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))handler;

@end

NS_INLINE UIAlertAction * defaultStyleAction(NSString *title, void (^handler)(UIAlertAction *action)) {

    return [UIAlertAction defaultStyleActionWithTitle:title handler:handler];
}

NS_INLINE UIAlertAction * cancelStyleAction(NSString *title, void (^handler)(UIAlertAction *action)) {
    
    return [UIAlertAction cancelStyleActionWithTitle:title handler:handler];
}

NS_INLINE UIAlertAction * destructiveStyleAction(NSString *title, void (^handler)(UIAlertAction *action)) {
    
    return [UIAlertAction destructiveStyleActionWithTitle:title handler:handler];
}



