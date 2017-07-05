//
//  NSAttributedString+AttributedStringConfig.h
//  AttributedString
//
//  Created by YouXianMing on 2017/6/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributedStringConfig.h"

@interface NSAttributedString (AttributedStringConfig)

/**
 [构造器] 便利的设置不可变富文本对象
 
 @param string 字符串
 @param configBlock 配置的AttributedStringConfig数组
 @return 富文本对象
 */
+ (instancetype)attributedStringWithString:(NSString *)string
                                    config:(void (^)(NSMutableArray <AttributedStringConfig *> *configs))configBlock;

@end
