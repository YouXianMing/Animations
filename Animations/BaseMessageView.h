//
//  BaseMessageView.h
//  MessageView
//
//  Created by YouXianMing on 2017/1/3.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseMessageView;

@protocol BaseMessageViewDelegate <NSObject>

@optional

/**
 The tap event or other event, etc.

 @param messageView The kindof messageView object.
 @param event The event.
 */
- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event;

/**
 The BaseMessageView will appear.

 @param messageView The kindof messageView object.
 */
- (void)baseMessageViewWillAppear:(__kindof BaseMessageView *)messageView;

/**
 The BaseMessageView did appear.
 
 @param messageView The kindof messageView object.
 */
- (void)baseMessageViewDidAppear:(__kindof BaseMessageView *)messageView;

/**
 The BaseMessageView will disappear.
 
 @param messageView The kindof messageView object.
 */
- (void)baseMessageViewWillDisappear:(__kindof BaseMessageView *)messageView;

/**
 The BaseMessageView did disappear.
 
 @param messageView The kindof messageView object.
 */
- (void)baseMessageViewDidDisappear:(__kindof BaseMessageView *)messageView;

@end

@interface BaseMessageView : UIView

/**
 The delegate.
 */
@property (nonatomic, weak) id <BaseMessageViewDelegate> delegate;

/**
 The message object.
 */
@property (nonatomic, strong) id messageObject;

/**
 The contentView.
 */
@property (nonatomic, weak) UIView *contentView;

/**
 The contentView's UserInteractionEnabled, default is YES, if you set it to NO, you should manage the value by yourself.
 */
@property (nonatomic) BOOL contentViewUserInteractionEnabled;

/**
 *  Auto hiden or not, default is NO.
 */
@property (nonatomic) BOOL autoHiden;

/**
 *  If The autoHiden is YES, you should set the delay hiden duration, default is 2.0.
 */
@property (nonatomic) NSTimeInterval delayAutoHidenDuration;

/**
 *  Show the MessageView.
 */
- (void)show;

/**
 *  Hide the MessageView.
 */
- (void)hide;

#pragma mark - Constructor.

/**
 The BaseMessageView Constructor.

 @param messageObject The message object.
 @param delegate The delegate.
 @param contentView The contentView.
 @param tag The view tag.
 @param autoHiden Auto hiden or not.
 @param delayAutoHidenDuration If The autoHiden is YES, you should set the delay hiden duration, default is 2.0.
 @param contentViewUserInteractionEnabled The contentView's user interaction enable or not.
 @param showImmediately Show the BaseMessageView immediately or not.
 @return The BaseMessageView.
 */
+ (instancetype)messageViewWithMessageObject:(id)messageObject
                                    delegate:(id <BaseMessageViewDelegate>)delegate
                                 contentView:(UIView *)contentView
                                     viewTag:(NSInteger)tag
                                   autoHiden:(BOOL)autoHiden
                      delayAutoHidenDuration:(NSTimeInterval)delayAutoHidenDuration
           contentViewUserInteractionEnabled:(BOOL)contentViewUserInteractionEnabled
                             showImmediately:(BOOL)showImmediately;

/**
 The BaseMessageView Constructor, auto hiden, contentViewUserInteractionEnabled is NO.

 @param messageObject The message object.
 @param contentView The contentView.
 @return The BaseMessageView.
 */
+ (instancetype)showAutoHiddenMessageViewWithMessageObject:(id)messageObject contentView:(UIView *)contentView;

/**
 The BaseMessageView Constructor, manual hiden, contentViewUserInteractionEnabled is NO.
 
 @param messageObject The message object.
 @param contentView The contentView.
 @return The BaseMessageView.
 */
+ (instancetype)showManualHiddenMessageViewWithMessageObject:(id)messageObject contentView:(UIView *)contentView;

/**
 The BaseMessageView Constructor, auto hiden, contentViewUserInteractionEnabled is NO.

 @param messageObject The message object.
 @param delegate The delegate.
 @param contentView The contentView.
 @param tag The view tag.
 @return The BaseMessageView.
 */
+ (instancetype)showAutoHiddenMessageViewWithMessageObject:(id)messageObject delegate:(id <BaseMessageViewDelegate>)delegate
                                               contentView:(UIView *)contentView viewTag:(NSInteger)tag;

/**
 The BaseMessageView Constructor, manual hiden, contentViewUserInteractionEnabled is NO.
 
 @param messageObject The message object.
 @param delegate The delegate.
 @param contentView The contentView.
 @param tag The view tag.
 @return The BaseMessageView.
 */
+ (instancetype)showManualHiddenMessageViewWithMessageObject:(id)messageObject delegate:(id <BaseMessageViewDelegate>)delegate
                                                 contentView:(UIView *)contentView viewTag:(NSInteger)tag;

/**
 The BaseMessageView Constructor, manual hiden, contentViewUserInteractionEnabled is YES.

 @param messageObject The message object.
 @return The BaseMessageView.
 */
+ (instancetype)showManualHiddenMessageViewInKeyWindowWithMessageObject:(id)messageObject;

/**
 The BaseMessageView Constructor, manual hiden, contentViewUserInteractionEnabled is YES.

 @param messageObject The message object.
 @param delegate The delegate.
 @param tag The view tag.
 @return The BaseMessageView.
 */
+ (instancetype)showManualHiddenMessageViewInKeyWindowWithMessageObject:(id)messageObject
                                                               delegate:(id <BaseMessageViewDelegate>)delegate
                                                                viewTag:(NSInteger)tag;

/**
 The BaseMessageView Constructor, auto hiden, contentViewUserInteractionEnabled is YES.

 @param messageObject The message object.
 @return The BaseMessageView.
 */
+ (instancetype)showAutoHiddenMessageViewInKeyWindowWithMessageObject:(id)messageObject;

/**
 The BaseMessageView Constructor, auto hiden, contentViewUserInteractionEnabled is YES.

 @param messageObject The message object.
 @param delegate The delegate.
 @param tag The view tag.
 @return The BaseMessageView.
 */
+ (instancetype)showAutoHiddenMessageViewInKeyWindowWithMessageObject:(id)messageObject
                                                             delegate:(id <BaseMessageViewDelegate>)delegate
                                                              viewTag:(NSInteger)tag;

+ (instancetype)showAutoHiddenMessageViewWithMessageObject:(id)messageObject
                                               contentView:(UIView *)contentView
                                    delayAutoHidenDuration:(NSTimeInterval)delayAutoHidenDuration;

+ (instancetype)showAutoHiddenMessageViewWithMessageObject:(id)messageObject
                                                  delegate:(id <BaseMessageViewDelegate>)delegate
                                               contentView:(UIView *)contentView
                                                   viewTag:(NSInteger)tag
                                    delayAutoHidenDuration:(NSTimeInterval)delayAutoHidenDuration;

+ (instancetype)showAutoHiddenMessageViewInKeyWindowWithMessageObject:(id)messageObject
                                               delayAutoHidenDuration:(NSTimeInterval)delayAutoHidenDuration;

+ (instancetype)showAutoHiddenMessageViewInKeyWindowWithMessageObject:(id)messageObject
                                                             delegate:(id <BaseMessageViewDelegate>)delegate
                                                              viewTag:(NSInteger)tag
                                               delayAutoHidenDuration:(NSTimeInterval)delayAutoHidenDuration;

@end



