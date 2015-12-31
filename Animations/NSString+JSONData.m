//
//  NSString+JSONData.m
//  Networking
//
//  Created by YouXianMing on 15/5/21.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "NSString+JSONData.h"

@implementation NSString (JSONData)

- (id)toListProperty {
    
    if (self) {
        
        NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
        return [NSJSONSerialization JSONObjectWithData:jsonData
                                               options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                 error:nil];
        
    } else {
        
        return nil;
    }
}

@end
