//
//  NetworkingInfo.m
//  Networking
//
//  Created by YouXianMing on 2017/8/18.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "NetworkingInfo.h"
#import "YXNetworking.h"

@implementation NetworkingInfo

- (void)showMessage {
    
    NSString *method = nil;
    switch (self.networking.method) {
            
        case kYXNetworkingGET:
            method = @"GET";
            break;
            
        case kYXNetworkingPOST:
            method = @"POST";
            break;
            
        case kYXNetworkingUPLOAD:
            method = @"UPLOAD";
            break;
            
        default:
            break;
    }
    
    NSLog(@"\n\n-------------------------------------------------------------------------\n服务描述: %@\n\n服务地址: [%@] %@\n\n参数列表: \n%@\n-------------------------------------------------------------------------\n\n",
          self.networking.serviceInfo,
          method,
          self.networking.urlString,
          [self.networking.requestParameterSerializer serializeRequestParameter:self.networking.requestParameter]);
}

@end
