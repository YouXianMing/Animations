//
//  NSObject+PropertiesInfomation.m
//  RuntimeModel
//
//  Created by YouXianMing on 16/6/10.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "NSObject+PropertiesInfomation.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation PropetyInfomation

@end

@implementation NSObject (PropertiesInfomation)

+ (NSMutableArray <PropetyInfomation *> *)propetyInfomations {

    NSMutableArray <PropetyInfomation *> *propetiesInfoArray = [NSMutableArray array];
    
    unsigned int     propertyCount = 0;
    objc_property_t *properties    = class_copyPropertyList([self class], &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; ++i) {
        
        objc_property_t property        = properties[i];
        PropetyInfomation *propertyInfo = [PropetyInfomation new];
        [propetiesInfoArray addObject:propertyInfo];
        
        propertyInfo.propertyName       = [NSString stringWithUTF8String:property_getName(property)];
        propertyInfo.propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
        propertyInfo.typeAttribute      = [propertyInfo.propertyAttributes componentsSeparatedByString:@","].firstObject;
        propertyInfo.propertyType       = [propertyInfo.typeAttribute substringFromIndex:1];
        
        if ([propertyInfo.typeAttribute hasPrefix:@"T@"] && propertyInfo.typeAttribute.length > 2) {
            
            // Get property info.
            NSString * typeClassName   = [propertyInfo.typeAttribute substringWithRange:NSMakeRange(3, propertyInfo.typeAttribute.length - 4)];
            Class      typeClass       = NSClassFromString(typeClassName);
            
            propertyInfo.propertyRealType = typeClassName;
            propertyInfo.propertyClass    = typeClass;
            
        } else {
            
            // Get unusual property info.
            const char *rawPropertyType = [propertyInfo.propertyType UTF8String];
            
            if (strcmp(rawPropertyType, @encode(id)) == 0) {
                
                propertyInfo.propertyRealType = @"id";
                
            } else if (strcmp(rawPropertyType, @encode(CGFloat)) == 0) {
                
                propertyInfo.propertyRealType = @"CGFloat";
                
            } else {
                
                NSLog(@"[UN-CHECKED-TYPE] - %@", propertyInfo.propertyType);
            }
        }
    }
    
    free(properties);
    
    return propetiesInfoArray;
}

@end
