//
//  WanDouJiaParameterSerializer.m
//  Animations
//
//  Created by YouXianMing on 2017/8/19.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "WanDouJiaParameterSerializer.h"
#import "DateFormatter.h"

@implementation WanDouJiaParameterSerializer

- (id)serializeRequestParameter:(id)requestParameter {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:requestParameter];
    
    [dic addEntriesFromDictionary:@{@"u"    : @"011f2924aa2cf27aa5dc8066c041fe08116a9a0c",
                                    @"v"    : @"1.8.0",
                                    @"date" : [DateFormatter dateStringFromDate:[NSDate date] outputDateStringFormatter:@"yyyyMMdd"],
                                    @"f"    : @"iphone"}];
    
    return dic;
}

@end
