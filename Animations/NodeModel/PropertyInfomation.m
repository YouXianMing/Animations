//
//  PropertyInfomation.m
//  NodeModel
//
//  Created by YouXianMing on 15/11/10.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "PropertyInfomation.h"

@implementation PropertyInfomation

+ (instancetype)propertyInfomationWithPropertyType:(PropertyType)type propertyValue:(id)propertyValue {

    PropertyInfomation *infomation = [[[self class] alloc] init];
    
    infomation.propertyType  = type;
    infomation.propertyValue = propertyValue;
    
    return infomation;
}

@end
