//
//  NSObject+PropertiesInfomation.h
//  RuntimeModel
//
//  Created by YouXianMing on 16/6/10.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropetyInfomation : NSObject

@property (nonatomic, strong) NSString *propertyName;
@property (nonatomic, strong) NSString *propertyRealType;
@property (nonatomic)         Class     propertyClass;

@property (nonatomic, strong) NSString *propertyAttributes;
@property (nonatomic, strong) NSString *typeAttribute;
@property (nonatomic, strong) NSString *propertyType;

@end

@interface NSObject (PropertiesInfomation)

+ (NSMutableArray <PropetyInfomation *> *)propetyInfomations;

@end
