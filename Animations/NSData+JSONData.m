//
//  NSData+JSONData.m
//  Networking
//
//  Created by YouXianMing on 15/8/4.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "NSData+JSONData.h"

@implementation NSData (JSONData)

- (id)toListProperty {

    if (self) {
        
        return [NSJSONSerialization JSONObjectWithData:self
                                               options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                 error:nil];
    } else {
    
        return nil;
    }
}

@end
