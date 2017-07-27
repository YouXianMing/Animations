//
//  ItemStyleInterface.h
//  Animations
//
//  Created by YouXianMing on 2017/7/27.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemStyleInterface <NSObject>

@required

/**
 获取到源对象并设置样式

 @param object 被设置样式的对象
 */
- (void)makeStyleEffectiveWithSourceObject:(id)object;

@end
