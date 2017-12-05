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
 *  Set the auto hidden delay seconds, if autoHiddenDelay > 0, it will auto hidden.
 */
@property (nonatomic) NSTimeInterval autoHiddenDelay;

/**
 *  Set this value when you want to use const auto hidden delay seconds.
 */
@property (class, nonatomic, readonly) NSTimeInterval constAutoHiddenDelaySeconds;

/**
 *  Show the MessageView.
 */
- (void)show;

/**
 *  Hide the MessageView.
 */
- (void)hide;

#pragma mark - Chain Programming.

/**
 *  Get the instance.
 */
+ (instancetype)build;

/**
 *  Set auto hidden, the delay seconds is 'constAutoHiddenDelaySeconds'.
 */
- (instancetype)autoHidden;

/**
 *  Disable the contentView's UserInteractionEnabled.
 */
- (instancetype)disableContentViewInteraction;

/**
 *  Chain with set delegate.
 */
- (BaseMessageView *(^)(id <BaseMessageViewDelegate> delegate))withDelegate;

/**
 *  Chain with set messageObject.
 */
- (BaseMessageView *(^)(id messageObject))withMessage;

/**
 *  Chain with set AutoHiddenDelay.
 */
- (BaseMessageView *(^)(NSTimeInterval seconds))withAutoHiddenDelay;

/**
 *  Chain with set view's tag.
 */
- (BaseMessageView *(^)(NSInteger tag))withTag;

/**
 *  Chain with set to show in contentView.
 */
- (BaseMessageView *(^)(UIView *contentView))showIn;

/**
 *  Chain with set to show in keyWindow.
 */
- (BaseMessageView *(^)(void))showInKeyWindow;

@end
