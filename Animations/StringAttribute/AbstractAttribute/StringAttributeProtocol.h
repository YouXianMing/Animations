//
//  StringAttributeProtocol.h
//  AttributeString
//
//  Created by YouXianMing on 15/8/3.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StringAttributeProtocol <NSObject>

#pragma mark - 必须实现
@required

/**
 *  属性名字
 *
 *  @return 属性名字
 */
- (NSString *)attributeName;

/**
 *  属性对应的值
 *
 *  @return 对应的值
 */
- (id)attributeValue;

@optional

#pragma mark - 可选实现
/**
 *  属性设置生效范围
 *
 *  @return 生效的范围
 */
- (NSRange)effectiveStringRange;

@end
