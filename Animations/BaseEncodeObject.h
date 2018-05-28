//
//  BaseEncodeObject.h
//  FamousQuotes
//
//  Created by YouXianMing on 2017/12/30.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEncodeObject : NSObject <NSCoding>

/**
 编码对象并返回二进制文件

 @return 编码后的二进制文件
 */
- (NSData *)encodeData;

/**
 将二进制文件解码成对象

 @param data 二进制文件
 @return 解码后的对象
 */
+ (instancetype)decodeWithData:(NSData *)data;

#pragma mark - AutoEncode

/**
 [子类重写] 自动Encode,DeEncode的属性名称数组
 */
@property (nonatomic, class, readonly) NSArray <NSString *> *autoEncodePropertyKeys;

/**
 [子类调用] 在encodeWithCoder中调用
 
 @param aCoder NSCoder对象
 @param aClass 当前类
 */
- (void)autoEncodePropertiesWithCoder:(NSCoder *)aCoder class:(Class)aClass;

/**
 [子类调用] 在initWithCoder中调用
 
 @param aDecoder NSCoder对象
 @param aClass 当前类
 */
- (void)autoDecoderPropertiesWithDecoder:(NSCoder *)aDecoder class:(Class)aClass;

@end
