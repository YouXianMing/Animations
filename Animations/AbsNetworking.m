//
//  AbsNetworking.m
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/3/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AbsNetworking.h"

@implementation AbsNetworking

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    self.method                     = [GetMethod type];
    self.requestBodyType            = [HttpBodyType type];
    self.responseDataType           = [HttpDataType type];
    self.requestParameterSerializer = [AbsRequestParameterSerializer new];
    self.responseDataSerializer     = [AbsResponseDataSerializer new];
    self.HTTPHeaderFieldsWithValues = [NSMutableDictionary dictionary];
    self.networkingInfomation       = [NSMutableDictionary dictionary];
    self.timeoutInterval            = @(5);
}

- (void)startRequest {
    
    [NSException raise:@"Networking startRequest"
                format:@"You must override this method."];
}

- (void)cancelRequest {
    
    [NSException raise:@"Networking cancelRequest"
                format:@"You must override this method."];
}

+ (id)getMethodNetworkingWithUrlString:(NSString *)urlString
                      requestParameter:(id)requestParameter
                       requestBodyType:(RequestBodyType *)requestBodyType
                      responseDataType:(ResponseDataType *)responseDataType {
    
    [NSException raise:@"Networking getMethodNetworkingWithUrlString:requestDictionary:requestBodyType:responseDataType:"
                format:@"You must override this method."];
    
    return nil;
}

+ (id)postMethodNetworkingWithUrlString:(NSString *)urlString
                       requestParameter:(id)requestParameter
                        requestBodyType:(RequestBodyType *)requestBodyType
                       responseDataType:(ResponseDataType *)responseDataType {
    
    [NSException raise:@"Networking postMethodNetworkingWithUrlString:requestDictionary:requestBodyType:responseDataType:"
                format:@"You must override this method."];
    
    return nil;
}

@end
