//
//  NSString+MD5.m
//  Animations
//
//  Created by YouXianMing on 16/1/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "NSString+MD5.h"
#import "MD5.h"

@implementation NSString (MD5)

- (NSString *)lowerMD532BitString {

    return [MD5 md532BitLower:self];
}

- (NSString *)upperMD532BitString {

    return [MD5 md532BitUpper:self];
}

@end
