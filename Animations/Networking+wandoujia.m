//
//  Networking+wandoujia.m
//  Animations
//
//  Created by YouXianMing on 2017/8/21.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "Networking+wandoujia.h"
#import "WanDouJiaParameterSerializer.h"
#import "WanDouJiaModelSerializer.h"

@implementation NetworkConfig

@end

@implementation Networking (wandoujia)

+ (instancetype)networkingWithNetworkConfig:(NetworkConfig *)config requestParameter:(id)requestParameter delegate:(id <NetworkingDelegate>)delegate {
    
    Networking *networking = [Networking networkingWithUrlString:config.urlString
                                                requestParameter:requestParameter
                                                          method:config.method
                                      requestParameterSerializer:[WanDouJiaParameterSerializer new]
                                          responseDataSerializer:[WanDouJiaModelSerializer new]
                                       constructingBodyWithBlock:nil
                                                        progress:nil
                                                             tag:config.tag
                                                        delegate:delegate
                                               requestSerializer:[AFHTTPRequestSerializer serializer]
                                              responseSerializer:[AFJSONResponseSerializer serializer]];
    
    networking.serviceInfo    = config.functionName;
    networking.networkingInfo = [NetworkingInfo new];
    
    return networking;
}

@end
