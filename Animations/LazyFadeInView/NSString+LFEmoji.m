//
//  NSString+LFEmoji.m
//  LazyFadeInView
//
//  Created by You Tu on 16/2/29.
//  Copyright © 2016年 Tu You. All rights reserved.
//

#import "NSString+LFEmoji.h"

@implementation NSString (LFEmoji)

- (NSArray *)lf_emojiRanges
{
    __block NSMutableArray *emojiRangesArray = [NSMutableArray new];
    
    [self enumerateSubstringsInRange:NSMakeRange(0,
                                                 [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring,
                                       NSRange substringRange,
                                       NSRange enclosingRange,
                                       BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f9c0) {
                     [emojiRangesArray addObject:[NSValue valueWithRange:substringRange]];
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3 || ls == 0xfe0f || ls == 0xd83c) {
                 [emojiRangesArray addObject:[NSValue valueWithRange:substringRange]];
             }
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 [emojiRangesArray addObject:[NSValue valueWithRange:substringRange]];
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 [emojiRangesArray addObject:[NSValue valueWithRange:substringRange]];
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 [emojiRangesArray addObject:[NSValue valueWithRange:substringRange]];
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 [emojiRangesArray addObject:[NSValue valueWithRange:substringRange]];
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 [emojiRangesArray addObject:[NSValue valueWithRange:substringRange]];
             }
         }
     }];
    
    return emojiRangesArray;
}

@end
