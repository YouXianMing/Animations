//
//  WanDouJiaModelSerializer.m
//  Animations
//
//  Created by YouXianMing on 2017/8/19.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "WanDouJiaModelSerializer.h"
#import "WanDouJiaModel.h"

@implementation WanDouJiaModelSerializer

- (id)serializeResponseData:(id)data {
    
    return [[WanDouJiaModel alloc] initWithDictionary:data];
}

@end
