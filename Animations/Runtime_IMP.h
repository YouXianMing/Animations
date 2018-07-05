//
//  Runtime_IMP.h
//  Runtime方法替换
//
//  Created by YouXianMing on 2018/7/5.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "Rumtime.h"

@interface Runtime_IMP : Rumtime

/**
 从一个指定的class里面获取他的IMP

 @param aClass 指定的class
 @param name 方法的名字
 @param isClassMethod 是否是类方法
 @return 指定的class里的IMP
 */
+ (instancetype)impWithClass:(Class)aClass name:(SEL)name isClassMethod:(BOOL)isClassMethod;

@property (nonatomic, readonly) BOOL  isClassMethod; // 是否是类方法
@property (nonatomic, readonly) Class aClass;        // 指定的类
@property (nonatomic, readonly) SEL   selector;      // 指定的类中的方法

@property (nonatomic, readonly) char *typeEncoding; // 方法的信息（参数值、返回值）
@property (nonatomic, readonly) IMP   imp;          // 方法的地址指针

@end
