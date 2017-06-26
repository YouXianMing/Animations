//
//  NSObject+ViewTag.h
//  Tag
//
//  Created by YouXianMing on 16/8/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (ViewTag)

/**
 根据key值获取指定的view
 
 @param identifier key值
 @return 存储的view.
 */
- (id)viewWithIdentifier:(NSString *)identifier;

/**
 根据value值获取指定的view
 
 @param value 设定的value值
 @return 存储的view.
 */
- (id)viewWithValue:(NSInteger)value;

/**
 将对象本身附着在指定的object上,并设定key值.
 
 @param object 指定的object对象.
 @param identifier key值.
 */
- (void)attachTo:(id)object setIdentifier:(NSString *)identifier;

/**
 将对象本身附着在指定的object上,并设定value值.
 
 @param object 指定的object对象.
 @param value 设定的value值.
 */
- (void)attachTo:(id)object setValue:(NSInteger)value;

@end
