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

@implementation Networking (wandoujia)

+ (instancetype)networkingWithUrlString:(NSString *)urlString
                       requestParameter:(id)requestParameter
                            serviceInfo:(NSString *)serviceInfo
                               delegate:(id <NetworkingDelegate>)delegate  {
    
    Networking *networking = [Networking networkingWithUrlString:urlString
                                                requestParameter:requestParameter
                                                          method:kYXNetworkingGET
                                      requestParameterSerializer:[WanDouJiaParameterSerializer new]
                                          responseDataSerializer:[WanDouJiaModelSerializer new]
                                                             tag:0
                                                        delegate:delegate
                                               requestSerializer:[AFHTTPRequestSerializer serializer]
                                              ResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    networking.serviceInfo    = serviceInfo;
    networking.networkingInfo = [NetworkingInfo new];
    
    return networking;
}

@end
