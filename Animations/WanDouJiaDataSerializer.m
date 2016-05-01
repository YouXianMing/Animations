//
//  WanDouJiaDataSerializer.m
//  Animations
//
//  Created by YouXianMing on 16/4/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "WanDouJiaDataSerializer.h"
#import "WanDouJiaModel.h"

@implementation WanDouJiaDataSerializer

- (id)serializeResponseData:(id)data {

    return [[WanDouJiaModel alloc] initWithDictionary:data];
}

@end
