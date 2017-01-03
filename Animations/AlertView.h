//
//  AlertView.h
//  Animations
//
//  Created by YouXianMing on 2017/1/3.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "BaseMessageView.h"

#pragma mark - AlertViewButtonStyle

typedef enum : NSUInteger {
    
    kAlertViewNormalStyle = 1000,
    kAlertViewRedStyle,
    
} EAlertViewButtonStyle;

@interface AlertViewButtonStyle : NSObject

@property (nonatomic, strong) NSString              *title;
@property (nonatomic)         EAlertViewButtonStyle  style;

@end

NS_INLINE AlertViewButtonStyle * AlertViewNormalStyle(NSString *title) {

    AlertViewButtonStyle *style = [AlertViewButtonStyle new];
    style.title                 = title;
    style.style                 = kAlertViewNormalStyle;
    
    return style;
}

NS_INLINE AlertViewButtonStyle * AlertViewRedStyle(NSString *title) {
    
    AlertViewButtonStyle *style = [AlertViewButtonStyle new];
    style.title                 = title;
    style.style                 = kAlertViewRedStyle;
    
    return style;
}

#pragma mark - AlertViewMessageObject

@interface AlertViewMessageObject : NSObject

@property (nonatomic, strong) NSString                         *content;
@property (nonatomic, strong) NSArray <AlertViewButtonStyle *> *buttonsTitle;

@end

NS_INLINE AlertViewMessageObject * MakeAlertViewMessageObject(NSString *content, NSArray <AlertViewButtonStyle *> *buttonsTitle) {
    
    AlertViewMessageObject *object = [AlertViewMessageObject new];
    object.content                 = content;
    object.buttonsTitle            = buttonsTitle;
    
    return object;
}

#pragma mark - AlertView

@interface AlertView : BaseMessageView

@end
