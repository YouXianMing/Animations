//
//  UIAlertController+Constructor.m
//  TechCode
//
//  Created by YouXianMing on 16/7/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UIAlertController+Constructor.h"

@implementation UIAlertController (Constructor)

+ (void)alertControllerShowInController:(UIViewController *)controller
                                  title:(NSString *)title
                                message:(NSString *)message
                         preferredStyle:(UIAlertControllerStyle)preferredStyle
                      alertActionsBlock:(void (^)(NSMutableArray <UIAlertAction *> *alertActions))alertActionsBlock
                             completion:(void (^)(void))completion {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:preferredStyle];
    
    NSMutableArray *alertActions = [NSMutableArray array];
    
    if (alertActionsBlock) {
        
        alertActionsBlock(alertActions);
    }
    
    for (UIAlertAction *action in alertActions) {
        
        [alertController addAction:action];
    }
    
    [controller presentViewController:alertController animated:YES completion:completion];
}

+ (void)actionSheetStyleShowInController:(UIViewController *)controller
                                   title:(NSString *)title
                                 message:(NSString *)message
                       alertActionsBlock:(void (^)(NSMutableArray <UIAlertAction *> *alertActions))alertActionsBlock
                              completion:(void (^)(void))completion {
    
    [[self class] alertControllerShowInController:controller
                                            title:title
                                          message:message
                                   preferredStyle:UIAlertControllerStyleActionSheet
                                alertActionsBlock:alertActionsBlock
                                       completion:completion];
}

+ (void)alertStyleShowInController:(UIViewController *)controller
                             title:(NSString *)title
                           message:(NSString *)message
                 alertActionsBlock:(void (^)(NSMutableArray <UIAlertAction *> *alertActions))alertActionsBlock
                        completion:(void (^)(void))completion {
    
    [[self class] alertControllerShowInController:controller
                                            title:title
                                          message:message
                                   preferredStyle:UIAlertControllerStyleAlert
                                alertActionsBlock:alertActionsBlock
                                       completion:completion];
}

@end
