//
//  Runtime_IMP.h
//  Test
//
//  Created by YouXianMing on 2018/7/4.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "Rumtime.h"
#import "Runtime_IMP.h"

@interface Runtime_Method : Rumtime

/**
 给一个指定的类添加一个方法

 @param aClass 指定的类
 @param name 新的方法名字
 @param imp name要绑定的IMP(IMP包含了完整的类名，以及该类的一个方法，以及是否是类方法)
 @return 是否添加成功
 */
+ (BOOL)addMethodWithClass:(Class)aClass methodName:(SEL)name methodIMP:(Runtime_IMP *)imp;

/**
 给一个指定的类替换方法

 @param aClass 指定的类
 @param name 要被替换的方法的名字
 @param imp 被替换方法的IMP
 */
+ (void)replaceMethodWithClass:(Class)aClass methodName:(SEL)name methodIMP:(Runtime_IMP *)imp;

/**
 交换方法

 @param imp1 交换方法的IMP
 @param imp2 交换方法的IMP
 */
+ (void)exchangeMethodIMP:(Runtime_IMP *)imp1 withIMP:(Runtime_IMP *)imp2;

@end
