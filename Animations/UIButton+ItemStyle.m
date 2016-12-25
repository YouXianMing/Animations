//
//  UIButton+ItemStyle.m
//  ItemObject
//
//  Created by YouXianMing on 2016/12/25.
//  Copyright © 2016年 TechCode. All rights reserved.
//

#import "UIButton+ItemStyle.h"
#import <objc/runtime.h>

@implementation UIButton (ItemStyle)

- (void)setStyle:(ItemStyle *)style {

    objc_setAssociatedObject(self, @selector(style), style, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    style.item = self;
    [style makeEffect];
}

- (ItemStyle *)style {

    return objc_getAssociatedObject(self, _cmd);
}

@end
