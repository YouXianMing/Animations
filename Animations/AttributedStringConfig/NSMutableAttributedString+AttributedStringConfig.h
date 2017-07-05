//
//  NSMutableAttributedString+AttributedStringConfig.h
//  AttributedString
//
//  Created by YouXianMing on 2017/6/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributedStringConfig.h"

@interface NSMutableAttributedString (AttributedStringConfig)

/**
 添加富文本对象
 
 @param stringAttribute 富文本配置对象
 */
- (void)addStringAttribute:(AttributedStringConfig *)stringAttribute;

/**
 移除富文本对象
 
 @param stringAttribute 富文本配置对象
 */
- (void)removeStringAttribute:(AttributedStringConfig *)stringAttribute;

/**
 [构造器] 便利构造出富文本对象(可变富文本,可以进行局部设置)
 
 @param string 文本
 @param configBlock AttributedStringConfig配置的数组,往里面添加AttributedStringConfig即可
 @return 富文本实体
 */
+ (instancetype)mutableAttributedStringWithString:(NSString *)string
                                           config:(void (^)(NSString *string, NSMutableArray <AttributedStringConfig *> *configs))configBlock;

@end
