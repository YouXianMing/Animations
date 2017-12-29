//
//  NSString+HexUnicode.h
//  FontInfo
//
//  Created by YouXianMing on 2017/12/29.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HexUnicode)

/**
 Transform hex string like '0xF181' to unicode '\u{F181}'.
 
 @param hexString The hex string like '0xF181'
 @return The unicode.
 */
+ (NSString *)unicodeWithHexString:(NSString *)hexString;

@end
