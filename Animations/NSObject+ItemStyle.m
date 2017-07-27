//
//  NSObject+ItemStyle.m
//  Animations
//
//  Created by YouXianMing on 2017/7/27.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "NSObject+ItemStyle.h"
#import <objc/runtime.h>

@implementation NSObject (ItemStyle)

- (void)setItemStyle:(id<ItemStyleInterface>)itemStyle {
 
    objc_setAssociatedObject(self, @selector(itemStyle), itemStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [itemStyle makeStyleEffectiveWithSourceObject:self];
}

- (id<ItemStyleInterface>)itemStyle {
    
    return objc_getAssociatedObject(self, _cmd);
}

@end
