//
//  V_2_X_Networking.m
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "V_2_X_Networking.h"
#import "AFNetworking.h"

@interface V_2_X_Networking ()

@property (nonatomic, strong) AFHTTPRequestOperationManager  *manager;
@property (nonatomic, strong) AFHTTPRequestOperation         *httpOperation;

@end

@implementation V_2_X_Networking

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        // 基本设置
        self.method           = [GetMethod type];
        self.requestBodyType  = [HttpBodyType type];
        self.responseDataType = [HttpDataType type];
        self.timeoutInterval  = @(5);
        
        // AFNetworking 2.x 相关初始化
        self.manager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

- (void)startRequest {
    
    NSParameterAssert(self.urlString);
    
    [self resetData];
    
    [self accessRequestSerializer];
    
    [self accessResponseSerializer];
    
    [self accessHeaderField];
    
    [self accessTimeoutInterval];
    
    // 开始运行
    self.isRunning = YES;
    
    if ([self.method isKindOfClass:[GetMethod class]]) {
        
        // GET请求
        NSDictionary *requstDictionary = [self accessRequestDictionarySerializerWithRequestDictionary:self.requestDictionary];
        
        __weak Networking *weakSelf = self;
        self.httpOperation = [self.manager GET:self.urlString
                                    parameters:requstDictionary
                                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                           
                                           weakSelf.isRunning            = NO;
                                           weakSelf.originalResponseData = responseObject;
                                           
                                           // 如果设置了转换策略，则进行数据转换
                                           if (weakSelf.responseDataSerializer && [weakSelf.responseDataSerializer respondsToSelector:@selector(serializeResponseData:)]) {
                                               
                                               weakSelf.serializerResponseData = [weakSelf.responseDataSerializer serializeResponseData:responseObject];
                                           }
                                           
                                           if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                               
                                               [weakSelf.delegate requestSucess:weakSelf
                                                                           data:(weakSelf.serializerResponseData == nil ? weakSelf.originalResponseData : weakSelf.serializerResponseData)];
                                           }
                                           
                                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           
                                           weakSelf.isRunning = NO;
                                           
                                           if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                               
                                               [weakSelf.delegate requestFailed:weakSelf error:error];
                                           }
                                       }];
        
    } else if ([self.method isKindOfClass:[PostMethod class]]) {
        
        // POST请求
        NSDictionary *requstDictionary = [self accessRequestDictionarySerializerWithRequestDictionary:self.requestDictionary];
        
        __weak Networking *weakSelf = self;
        self.httpOperation = [self.manager POST:self.urlString
                                     parameters:requstDictionary
                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            
                                            weakSelf.isRunning            = NO;
                                            weakSelf.originalResponseData = responseObject;
                                            
                                            // 如果设置了转换策略，则进行数据转换
                                            if (weakSelf.responseDataSerializer && [weakSelf.responseDataSerializer respondsToSelector:@selector(serializeResponseData:)]) {
                                                
                                                weakSelf.serializerResponseData = [weakSelf.responseDataSerializer serializeResponseData:responseObject];
                                            }
                                            
                                            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                                
                                                [weakSelf.delegate requestSucess:weakSelf
                                                                            data:(weakSelf.serializerResponseData == nil ? weakSelf.originalResponseData : weakSelf.serializerResponseData)];
                                            }
                                            
                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            
                                            weakSelf.isRunning = NO;
                                            
                                            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                                
                                                [weakSelf.delegate requestFailed:weakSelf error:error];
                                            }
                                        }];
    }
    
}

- (void)cancelRequest {
 
    [self.httpOperation cancel];
}

+ (id)getMethodNetworkingWithUrlString:(NSString *)urlString
                     requestDictionary:(NSDictionary *)requestDictionary
                       requestBodyType:(RequestBodyType *)requestBodyType
                      responseDataType:(ResponseDataType *)responseDataType {
    
    Networking *networking       = [[V_2_X_Networking alloc] init];
    networking.urlString         = urlString;
    networking.requestDictionary = requestDictionary;

    if (requestBodyType) {
        
        networking.requestBodyType = requestBodyType;
    }
    
    if (responseDataType) {
        
        networking.responseDataType = responseDataType;
    }
    
    return networking;
}

+ (id)postMethodNetworkingWithUrlString:(NSString *)urlString
                      requestDictionary:(NSDictionary *)requestDictionary
                        requestBodyType:(RequestBodyType *)requestBodyType
                       responseDataType:(ResponseDataType *)responseDataType {
    
    Networking *networking       = [[V_2_X_Networking alloc] init];
    networking.urlString         = urlString;
    networking.requestDictionary = requestDictionary;
    networking.method            = [PostMethod type];
    
    if (requestBodyType) {
        
        networking.requestBodyType = requestBodyType;
    }
    
    if (responseDataType) {
        
        networking.responseDataType = responseDataType;
    }
    
    return networking;
}

#pragma mark - 私有方法

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
        
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
    } else if ([self.requestBodyType isKindOfClass:[JsonBodyType class]]) {
        
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
    } else if ([self.requestBodyType isKindOfClass:[PlistBodyType class]]) {
        
        self.manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
        
    } else {
        
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
}

/**
 *  处理回复data类型
 */
- (void)accessResponseSerializer {
    
    if ([self.responseDataType isKindOfClass:[HttpDataType class]]) {
        
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    } else if ([self.responseDataType isKindOfClass:[JsonDataType class]]) {
        
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
    } else {
        
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
}

/**
 *  处理请求头部信息
 */
- (void)accessHeaderField {

    if (self.HTTPHeaderFieldsWithValues) {
        
        NSArray *allKeys = self.HTTPHeaderFieldsWithValues.allKeys;
        
        for (NSString *headerField in allKeys) {
            
            NSString *value = [self.HTTPHeaderFieldsWithValues valueForKey:headerField];
            [self.manager.requestSerializer setValue:value forHTTPHeaderField:headerField];
        }
    }
}

/**
 *  设置超时时间
 */
- (void)accessTimeoutInterval {

    if (self.timeoutInterval && self.timeoutInterval.floatValue > 0) {
        
        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer.timeoutInterval = self.timeoutInterval.floatValue;
        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
}

/**
 *  处理请求参数
 *
 *  @param requestDictionary 请求参数字典
 *
 *  @return 处理后的参数
 */
- (NSDictionary *)accessRequestDictionarySerializerWithRequestDictionary:(NSDictionary *)requestDictionary {

    if (self.requestDictionarySerializer &&
        [self.requestDictionarySerializer respondsToSelector:@selector(serializeRequestDictionary:)]) {
        
        return [self.requestDictionarySerializer serializeRequestDictionary:requestDictionary];
        
    } else {
    
        return requestDictionary;
    }
}

#pragma mark - 

- (void)dealloc {

    [self.httpOperation cancel];
}

@end
