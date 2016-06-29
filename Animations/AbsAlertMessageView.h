//
//  AbsAlertMessageView.h
//  TechCode
//
//  Created by YouXianMing on 16/5/15.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class AbsAlertMessageView;

@protocol AlertMessageViewDelegate <NSObject>

@optional

/**
 *  The AlertView's event.
 *
 *  @param alertView The AbsAlertMessageView object.
 *  @param index     Event data.
 *  @param data      Event index.
 */
- (void)alertView:(AbsAlertMessageView *)alertView clickAtIndex:(NSInteger)index data:(id)data;

/**
 *  The AlertView will show.
 *
 *  @param alertView The AbsAlertMessageView object.
 */
- (void)alertViewWillShow:(AbsAlertMessageView *)show;

/**
 *  The AlertView did show.
 *
 *  @param alertView The AbsAlertMessageView object.
 */
- (void)alertViewDidShow:(AbsAlertMessageView *)alertView;

/**
 *  The AlertView will hide.
 *
 *  @param alertView The AbsAlertMessageView object.
 */
- (void)alertViewWillHide:(AbsAlertMessageView *)alertView;

/**
 *  The AlertView did hide.
 *
 *  @param alertView The AbsAlertMessageView object.
 */
- (void)alertViewDidHide:(AbsAlertMessageView *)alertView;

@end

@interface AbsAlertMessageView : UIView

/**
 *  The AlertView event delegate.
 */
@property (nonatomic, weak)   id <AlertMessageViewDelegate> delegate;

/**
 *  The title, default is nil.
 */
@property (nonatomic, strong) NSString  *title;

/**
 *  The subtitle, default is nil.
 */
@property (nonatomic, strong) NSString  *subTitle;

/**
 *  The message, default is nil.
 */
@property (nonatomic, strong) NSString  *message;

/**
 *  Customed Message, default is nil.
 */
@property (nonatomic, strong) id         customedMessage;

/**
 *  Button's title array, default is nil.
 */
@property (nonatomic, strong) NSArray   <NSString *>  *buttonsTitle;

/**
 *  Button's config array, default is nil.
 */
@property (nonatomic, strong) NSArray   *buttonsConfig;

/**
 *  The contentView.
 */
@property (nonatomic, weak)   UIView    *contentView;

/**
 *  Auto hiden or not, default is NO.
 */
@property (nonatomic)         BOOL       autoHiden;

/**
 *  If The autoHiden is YES, you should set the delay hiden duration, default is 2.0.
 */
@property (nonatomic)         NSTimeInterval    delayAutoHidenDuration;

/**
 *  Show the AlertView.
 */
- (void)show;

/**
 *  Hide the AlertView.
 */
- (void)hide;

/**
 *  Store View with key.
 *
 *  @param view View.
 *  @param key  Key.
 */
- (void)setView:(UIView *)view withKey:(NSString *)key;

/**
 *  Get View with key.
 *
 *  @param key Key.
 *
 *  @return View.
 */
- (UIView *)viewWithKey:(NSString *)key;

@end
