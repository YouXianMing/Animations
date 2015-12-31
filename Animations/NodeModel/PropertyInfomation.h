//
//  PropertyInfomation.h
//  NodeModel
//
//  Created by YouXianMing on 15/11/10.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    kNSString,
    kNSNumber,
    kNull,
    kNSDictionary,
    kNSArray,
    
} PropertyType;

@interface PropertyInfomation : NSObject

/**
 *  属性类型
 */
@property (nonatomic) PropertyType  propertyType;

/**
 *  属性代表值
 */
@property (nonatomic, weak) id      propertyValue;

/**
 *  便利构造器
 *
 *  @param type          属性类型
 *  @param propertyValue 属性代表值
 *
 *  @return 实例对象
 */
+ (instancetype)propertyInfomationWithPropertyType:(PropertyType)type propertyValue:(id)propertyValue;

@end
