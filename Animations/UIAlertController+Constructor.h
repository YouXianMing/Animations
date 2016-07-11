//
//  UIAlertController+Constructor.h
//  TechCode
//
//  Created by YouXianMing on 16/7/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAlertAction+Constructor.h"

@interface UIAlertController (Constructor)

/**
 *  AlertController show in controller.
 *
 *  @param controller        The controller to show the AlertController.
 *  @param title             Title.
 *  @param message           Message.
 *  @param preferredStyle    Constants indicating the type of alert to display.
 *  @param alertActionsBlock An array to add UIAlertActions.
 *  @param completion        The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
 */
+ (void)alertControllerShowInController:(UIViewController *)controller
                                  title:(NSString *)title
                                message:(NSString *)message
                         preferredStyle:(UIAlertControllerStyle)preferredStyle
                      alertActionsBlock:(void (^)(NSMutableArray <UIAlertAction *> *alertActions))alertActionsBlock
                             completion:(void (^)(void))completion;

/**
 *  Alert style AlertController show in controller.
 *
 *  @param controller        The controller to show the AlertController.
 *  @param title             Title.
 *  @param message           Message.
 *  @param alertActionsBlock An array to add UIAlertActions.
 *  @param completion        The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
 */
+ (void)alertStyleShowInController:(UIViewController *)controller
                             title:(NSString *)title
                           message:(NSString *)message
                 alertActionsBlock:(void (^)(NSMutableArray <UIAlertAction *> *alertActions))alertActionsBlock
                        completion:(void (^)(void))completion;

/**
 *  Action style AlertController show in controller.
 *
 *  @param controller        The controller to show the AlertController.
 *  @param title             Title.
 *  @param message           Message.
 *  @param alertActionsBlock An array to add UIAlertActions.
 *  @param completion        The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
 */
+ (void)actionSheetStyleShowInController:(UIViewController *)controller
                                   title:(NSString *)title
                                 message:(NSString *)message
                       alertActionsBlock:(void (^)(NSMutableArray <UIAlertAction *> *alertActions))alertActionsBlock
                              completion:(void (^)(void))completion;

@end
