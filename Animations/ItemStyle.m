//
//  ItemStyle.m
//  ItemStyle
//
//  Created by YouXianMing on 2017/7/27.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ItemStyle.h"

@implementation ItemStyle

- (void)makeStyleEffective {
    
    [NSException raise:@"Use ItemStyle in the wrong way."
                format:@"You should overwrite the method 'makeStyleEffective', not override."];
}

+ (instancetype)style {
    
    return [[[self class] alloc] init];
}

@end
