//
//  NSString+HexUnicode.m
//  FontInfo
//
//  Created by YouXianMing on 2017/12/29.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "NSString+HexUnicode.h"

@implementation NSString (HexUnicode)

+ (NSString *)unicodeWithHexString:(NSString *)hexString {
    
    unsigned int codeValue;
    [[NSScanner scannerWithString:hexString] scanHexInt:&codeValue];
    
    return [NSString stringWithFormat:@"%C", (unichar)codeValue];;
}

@end
