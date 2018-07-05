//
//  Runtime_IMP.m
//  Runtime方法替换
//
//  Created by YouXianMing on 2018/7/5.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "Runtime_IMP.h"

@interface Runtime_IMP ()

@property (nonatomic) BOOL  isClassMethod;
@property (nonatomic) Class aClass;
@property (nonatomic) SEL   selector;

@end

@implementation Runtime_IMP

+ (instancetype)impWithClass:(Class)aClass name:(SEL)name isClassMethod:(BOOL)isClassMethod {
    
    Runtime_IMP *imp  = [Runtime_IMP new];
    imp.aClass        = aClass;
    imp.selector      = name;
    imp.isClassMethod = isClassMethod;
    
    return imp;
}

- (char *)typeEncoding {
    
    Class class = self.isClassMethod ? objc_getMetaClass(NSStringFromClass(self.aClass).UTF8String) : self.aClass;
    return (char *)method_getTypeEncoding(class_getInstanceMethod(class, self.selector));
}

- (IMP)imp {
    
    Class class = self.isClassMethod ? objc_getMetaClass(NSStringFromClass(self.aClass).UTF8String) : self.aClass;
    return class_getMethodImplementation(class, self.selector);
}

@end
