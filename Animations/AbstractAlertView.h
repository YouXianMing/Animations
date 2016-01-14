//
//  AbstractAlertView.h
//  Animations
//
//  Created by YouXianMing on 16/1/2.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class AbstractAlertView;

@protocol AbstractAlertViewDelegate <NSObject>

@optional

/**
 *  The AlertView's event.
 *
 *  @param alertView The AlertViewProtocol object.
 *  @param event     Event data.
 *  @param index     Event index.
 */
- (void)alertView:(AbstractAlertView *)alertView data:(id)data atIndex:(NSInteger)index;

/**
 *  The AlertView will hide.
 *
 *  @param alertView The AlertViewProtocol object.
 */
- (void)alertViewWillHide:(AbstractAlertView *)alertView;

/**
 *  The AlertView did hide.
 *
 *  @param alertView The AlertViewProtocol object.
 */
- (void)alertViewDidHide:(AbstractAlertView *)alertView;

@end

@interface AbstractAlertView : UIView

/**
 *  The AlertView event delegate.
 */
@property (nonatomic, weak)   id <AbstractAlertViewDelegate> delegate;

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
 *  Button's title array, default is nil.
 */
@property (nonatomic, strong) NSArray   <NSString *>  *buttonsTitle;

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
