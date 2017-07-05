//
//  NSString+AttributedStringConfig.h
//  AttributedString
//
//  Created by YouXianMing on 2017/6/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributedStringConfig.h"

@interface NSString (AttributedStringConfig)

/**
 局部设定的富文本(局部有效,每一个AttributedStringConfig均影响其中的一部分,effectiveStringRange有效)

 @param attributes AttributedStringConfig构成的数组
 @return 局部设定的富文本
 */
- (NSMutableAttributedString *)mutableAttributedStringWithStringAttributes:(NSArray <AttributedStringConfig *> *)attributes;

/**
 全局设定的富文本(整个文本设置有效,AttributedStringConfig中的effectiveStringRange无效)

 @param attributes AttributedStringConfig构成的数组
 @return 全局设定的富文本
 */
- (NSAttributedString *)attributedStringWithStringAttributes:(NSArray <AttributedStringConfig *> *)attributes;

/**
 全局设定的富文本(整个文本设置有效,AttributedStringConfig中的effectiveStringRange无效)

 @param configBlock 用来添加AttributedStringConfig的数组
 @return 全局设定的富文本
 */
- (NSAttributedString *)attributedStringWithConfigs:(void (^)(NSMutableArray <AttributedStringConfig *> *configs))configBlock;

@end
