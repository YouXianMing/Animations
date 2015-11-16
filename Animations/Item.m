//
//  Item.m
//  Facebook-POP-Animation
//
//  Created by YouXianMing on 15/11/16.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "Item.h"

@implementation Item

+ (instancetype)itemWithName:(NSString *)name object:(id)object {

    Item *item  = [[[self class] alloc] init];
    item.name   = name;
    item.object = object;
    
    return item;
}

@end
