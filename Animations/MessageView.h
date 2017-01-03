//
//  MessageView.h
//  Animations
//
//  Created by YouXianMing on 2017/1/3.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "BaseMessageView.h"

#pragma mark - MessageViewObject

@interface MessageViewObject : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

+ (instancetype)messageViewObjectWithTitle:(NSString *)title content:(NSString *)content;

@end

NS_INLINE MessageViewObject * MakeMessageViewObject(NSString *title, NSString *content) {
    
    return [MessageViewObject messageViewObjectWithTitle:title content:content];
}

#pragma mark - MessageView

@interface MessageView : BaseMessageView

@end

