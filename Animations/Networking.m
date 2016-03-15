//
//  Networking.m
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/3/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "Networking.h"
#import "AFNetworking.h"

@interface Networking ()

@property (nonatomic, strong) AFHTTPSessionManager *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation Networking

- (void)setup {
    
    [super setup];
    
    // AFNetworking 3.x 相关初始化
    self.session = [AFHTTPSessionManager manager];
}

- (void)startRequest {
    
    NSParameterAssert(self.urlString);
    NSParameterAssert(self.requestParameterSerializer);
    NSParameterAssert(self.responseDataSerializer);
    
    [self resetData];
    [self accessRequestSerializer];
    [self accessResponseSerializer];
    [self accessHeaderField];
    [self accessTimeoutInterval];
    
    if ([self.method isKindOfClass:[GetMethod class]]) {
        
        [self accessGetRequest];
        
    } else if ([self.method isKindOfClass:[PostMethod class]]) {
        
        [self accessPostRequest];
    }
    
    [self safetySetKey:@"absoluteString"         object:self.dataTask.currentRequest.URL.absoluteString];
    [self safetySetKey:@"host"                   object:self.dataTask.currentRequest.URL.host];
    [self safetySetKey:@"query"                  object:self.dataTask.currentRequest.URL.query];
    [self safetySetKey:@"scheme"                 object:self.dataTask.currentRequest.URL.scheme];
    [self safetySetKey:@"timeoutInterval"        object:@(self.dataTask.currentRequest.timeoutInterval)];
    [self safetySetKey:@"allHTTPHeaderFields"    object:self.dataTask.currentRequest.allHTTPHeaderFields];
    [self safetySetKey:@"acceptableContentTypes" object:self.session.responseSerializer.acceptableContentTypes];
    [self safetySetKey:@"parameter"              object:self.requestParameter];
}

- (void)safetySetKey:(NSString *)key object:(id)object {
    
    if (object) {
        
        [self.networkingInfomation setObject:object forKey:key];
    }
}

- (void)cancelRequest {
    
    [self.dataTask cancel];
}

- (void)accessGetRequest {
    
    self.isRunning              = YES;
    __weak Networking *weakSelf = self;
    
    self.dataTask = [self.session GET:self.urlString
                           parameters:[self.requestParameterSerializer serializeRequestParameter:self.requestParameter]
                             progress:nil
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  
                                  weakSelf.isRunning              = NO;
                                  weakSelf.originalResponseData   = responseObject;
                                  weakSelf.serializerResponseData = [weakSelf.responseDataSerializer serializeResponseData:responseObject];
                                  
                                  if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                      
                                      [weakSelf.delegate requestSucess:weakSelf data:weakSelf.serializerResponseData];
                                  }
                                  
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  
                                  weakSelf.isRunning = NO;
                                  
                                  if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                      
                                      [weakSelf.delegate requestFailed:weakSelf error:error];
                                  }
                              }];
}

- (void)accessPostRequest {
    
    self.isRunning              = YES;
    __weak Networking *weakSelf = self;
    
    self.dataTask = [self.session POST:self.urlString
                            parameters:[self.requestParameterSerializer serializeRequestParameter:self.requestParameter]
                              progress:nil
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   
                                   weakSelf.isRunning              = NO;
                                   weakSelf.originalResponseData   = responseObject;
                                   weakSelf.serializerResponseData = [weakSelf.responseDataSerializer serializeResponseData:responseObject];
                                   
                                   if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                       
                                       [weakSelf.delegate requestSucess:weakSelf data:weakSelf.serializerResponseData];
                                   }
                                   
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   
                                   weakSelf.isRunning = NO;
                                   
                                   if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                       
                                       [weakSelf.delegate requestFailed:weakSelf error:error];
                                   }
                               }];
}

/**
 *  重置数据
 */
- (void)resetData {
    
    self.originalResponseData   = nil;
    self.serializerResponseData = nil;
}

/**
 *  处理请求body类型
 */
- (void)accessRequestSerializer {
    
    if ([self.requestBodyType isKindOfClass:[HttpBodyType class]]) {
        
        self.session.requestSerializer = [AFHTTPRequestSerializer serializer];
        
    } else if ([self.requestBodyType isKindOfClass:[JsonBodyType class]]) {
        
        self.session.requestSerializer = [AFJSONRequestSerializer serializer];
        
    } else if ([self.requestBodyType isKindOfClass:[PlistBodyType class]]) {
        
        self.session.requestSerializer = [AFPropertyListRequestSerializer serializer];
        
    } else {
        
        self.session.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
}

/**
 *  处理回复data类型
 */
- (void)accessResponseSerializer {
    
    if ([self.responseDataType isKindOfClass:[HttpDataType class]]) {
        
        self.session.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    } else if ([self.responseDataType isKindOfClass:[JsonDataType class]]) {
        
        self.session.responseSerializer = [AFJSONResponseSerializer serializer];
        
    } else {
        
        self.session.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    self.session.responseSerializer.acceptableContentTypes = [self.session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    self.session.responseSerializer.acceptableContentTypes = [self.session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
}

/**
 *  处理请求头部信息
 */
- (void)accessHeaderField {
    
    if (self.HTTPHeaderFieldsWithValues) {
        
        NSArray *allKeys = self.HTTPHeaderFieldsWithValues.allKeys;
        
        for (NSString *headerField in allKeys) {
            
            NSString *value = [self.HTTPHeaderFieldsWithValues valueForKey:headerField];
            [self.session.requestSerializer setValue:value forHTTPHeaderField:headerField];
        }
    }
}

/**
 *  设置超时时间
 */
- (void)accessTimeoutInterval {
    
    if (self.timeoutInterval && self.timeoutInterval.floatValue > 0) {
        
        [self.session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.session.requestSerializer.timeoutInterval = self.timeoutInterval.floatValue;
        [self.session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
}

+ (id)getMethodNetworkingWithUrlString:(NSString *)urlString
                      requestParameter:(id)requestParameter
                       requestBodyType:(RequestBodyType *)requestBodyType
                      responseDataType:(ResponseDataType *)responseDataType {
    
    Networking *networking      = [[Networking alloc] init];
    networking.urlString        = urlString;
    networking.requestParameter = requestParameter;
    
    if (requestBodyType) {
        
        networking.requestBodyType = requestBodyType;
    }
    
    if (responseDataType) {
        
        networking.responseDataType = responseDataType;
    }
    
    return networking;
}

+ (id)postMethodNetworkingWithUrlString:(NSString *)urlString
                       requestParameter:(id)requestParameter
                        requestBodyType:(RequestBodyType *)requestBodyType
                       responseDataType:(ResponseDataType *)responseDataType {
    
    Networking *networking      = [[Networking alloc] init];
    networking.urlString        = urlString;
    networking.requestParameter = requestParameter;
    networking.method            = [PostMethod type];
    
    if (requestBodyType) {
        
        networking.requestBodyType = requestBodyType;
    }
    
    if (responseDataType) {
        
        networking.responseDataType = responseDataType;
    }
    
    return networking;
}

@end
