//
//  SignMaker.m
//  MakeSign
//
//  Created by YouXianMing on 16/1/13.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SignMaker.h"

@implementation SignMaker

+ (NSString *)signMakerWithDictionary:(NSDictionary <NSString *, NSString *> *)dictionary {
    
    // Sort keys.
    NSArray *sort = [dictionary.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        
        return [str1 compare:str2];
    }];
    
    // Make string.
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < sort.count; i++) {
        
        NSString *key   = sort[i];
        NSString *value = [NSString stringWithUTF8String:[dictionary[key] UTF8String]];
        [string appendFormat:@"%@=%@", key, value
         ];
        
        if (i != sort.count - 1) {
            
            [string appendString:@"&"];
        }
    }

    // Make code.
    int normalCode = [self hashCodeJavaLike:string];
    
    // Make code string.
    NSString *codeString = [[NSString alloc] initWithFormat:@"%x", normalCode];
    
    return codeString;
}

+ (int)hashCodeJavaLike:(NSString *)string {
    
    int       h   = 0;
    NSInteger len = string.length;
    
    for (int i = 0; i < len; i++) {
        
        //this get the ascii value of the character at position
        char charAsciiValue = [string characterAtIndex:i];
        
        //product sum algorithm over the entire text of the string
        h = 31*h + charAsciiValue;
    }
    
    return h;
}

@end
