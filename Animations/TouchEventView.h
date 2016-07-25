//
//  TouchEventView.h
//  UITextFieldView
//
//  Created by YouXianMing on 16/7/25.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TouchEventView;

typedef enum : NSUInteger {

    /**
     *  Let the contentView to add subViews, attention, this event will be executed only once.
     */
    kTouchEventViewAddSubViews = 1000,
    
    /**
     *  Button's event, you should set the property 'touchEnabled' to YES.
     */
    kTouchEventViewButtonEvent,
    
} ETouchEventViewEventType;

/**
 *  The TouchEventView's event block.
 *
 *  @param touchEventView The TouchEventView's object.
 *  @param eventType      The event type.
 */
typedef void (^touchEventViewBlock_t)(TouchEventView *touchEventView, ETouchEventViewEventType eventType);

@interface TouchEventView : UIView

/**
 *  Default is NO.
 */
@property (nonatomic) BOOL touchEnabled;

/**
 *  The view to add subView.
 */
@property (nonatomic, strong) UIView *contentView;

/**
 *  Create TouchEventView.
 *
 *  @param frame The TouchEventView's frame.
 *  @param block The block.
 *
 *  @return TouchEventView's object.
 */
+ (instancetype)touchEventViewWithFrame:(CGRect)frame block:(touchEventViewBlock_t)block;

@end
