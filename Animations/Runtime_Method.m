//
//  Runtime_IMP.m
//  Test
//
//  Created by YouXianMing on 2018/7/4.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "Runtime_Method.h"

@implementation Runtime_Method

+ (BOOL)addMethodWithClass:(Class)aClass methodName:(SEL)name methodIMP:(Runtime_IMP *)imp; {

    Class class = imp.isClassMethod ? objc_getMetaClass(NSStringFromClass(aClass).UTF8String) : aClass;
    return class_addMethod(class, name, imp.imp, imp.typeEncoding);
}

+ (void)replaceMethodWithClass:(Class)aClass methodName:(SEL)name methodIMP:(Runtime_IMP *)imp {
    
    Class class = imp.isClassMethod ? objc_getMetaClass(NSStringFromClass(aClass).UTF8String) : aClass;
    class_replaceMethod(class, name, imp.imp, imp.typeEncoding);
}

+ (void)exchangeMethodIMP:(Runtime_IMP *)imp1 withIMP:(Runtime_IMP *)imp2 {
    
    if (imp1.isClassMethod == NO && imp2.isClassMethod == NO) {
        
        method_exchangeImplementations(class_getInstanceMethod(imp1.aClass, imp1.selector),
                                       class_getInstanceMethod(imp2.aClass, imp2.selector));
        
    } else if (imp1.isClassMethod == YES && imp2.isClassMethod == YES) {
        
        method_exchangeImplementations(class_getClassMethod(imp1.aClass, imp1.selector),
                                       class_getClassMethod(imp2.aClass, imp2.selector));
        
    } else {
        
        [NSException raise:@"参数错误" format:@"IMP1与IMP2的isClassMethod的值不匹配。"];
    }
}

@end
