//
//  AbsNetworking.h
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/3/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestMethodType.h"
#import "RequestBodyType.h"
#import "ResponseDataType.h"
#import "AbsRequestParameterSerializer.h"
#import "AbsResponseDataSerializer.h"

@class AbsNetworking;

@protocol AbsNetworkingDelegate <NSObject>

/**
 *  请求成功
 *
 *  @param networking networking对象
 *  @param data       数据
 */
- (void)requestSucess:(AbsNetworking *)networking data:(id)data;

/**
 *  请求失败
 *
 *  @param networking networking对象
 *  @param error      错误信息
 */
- (void)requestFailed:(AbsNetworking *)networking error:(NSError *)error;

@end

@interface AbsNetworking : NSObject

#pragma mark - 设置参数

/**
 *  网络请求地址（空网址直接崩溃）
 */
@property (nonatomic, strong)   NSString *urlString;

/**
 *  请求方法类型（如 GET，POST等）
 */
@property (nonatomic, strong)   RequestMethodType *method;

/**
 *  设置请求头部信息
 */
@property (nonatomic, strong)   NSDictionary      *HTTPHeaderFieldsWithValues;

/**
 *  请求方式类型（如HTTP请求的方式、JSON序列化请求方式、PropertyList请求方式等）
 */
@property (nonatomic, strong)   RequestBodyType   *requestBodyType;

/**
 *  回复数据的类型（如返回的数据为二进制data、序列化的JSON数据等）
 */
@property (nonatomic, strong)   ResponseDataType  *responseDataType;

/**
 *  代理
 */
@property (nonatomic, weak)     id <AbsNetworkingDelegate> delegate;

/**
 *  请求用参数（字典或者数组）
 */
@property (nonatomic, strong)   id requestParameter;

/**
 *  请求标记
 */
@property (nonatomic)           NSInteger tag;

/**
 *  请求超时时间间隔（不设置的话默认值为5s）
 */
@property (nonatomic, strong)   NSNumber *timeoutInterval;

/**
 *  处理请求字典参数（不设置的话默认不处理）
 */
@property (nonatomic, strong)   AbsRequestParameterSerializer   *requestParameterSerializer;

/**
 *  处理返回的数据
 */
@property (nonatomic, strong)   AbsResponseDataSerializer       *responseDataSerializer;

#pragma mark - 运行时候的参数

/**
 *  是否正在请求当中
 */
@property (nonatomic)         BOOL  isRunning;

/**
 *  没有处理过的原始数据
 */
@property (nonatomic, strong) id  originalResponseData;

/**
 *  处理过的原始数据
 */
@property (nonatomic, strong) id  serializerResponseData;

/**
 *  请求的一些信息
 */
@property (nonatomic, strong) NSMutableDictionary  *networkingInfomation;

#pragma mark - 初始化设置

/**
 *  初始化设置
 */
- (void)setup;

#pragma mark - 请求方法

/**
 *  开始请求
 */
- (void)startRequest;

/**
 *  取消请求
 */
- (void)cancelRequest;

#pragma mark - 便利构造器

/**
 *  GET请求
 *
 *  @param urlString         网址
 *  @param requestParameter  请求参数（字典或者数组）
 *  @param requestBodyType   请求包体类型
 *  @param responseDataType  回复数据类型
 *
 *  @return Networking对象
 */
+ (id)getMethodNetworkingWithUrlString:(NSString *)urlString
                      requestParameter:(id)requestParameter
                       requestBodyType:(RequestBodyType *)requestBodyType
                      responseDataType:(ResponseDataType *)responseDataType;

/**
 *  POST请求
 *
 *  @param urlString         网址
 *  @param requestParameter  请求参数（字典或者数组）
 *  @param requestBodyType   请求包体类型
 *  @param responseDataType  回复数据类型
 *
 *  @return Networking对象
 */
+ (id)postMethodNetworkingWithUrlString:(NSString *)urlString
                       requestParameter:(id)requestParameter
                        requestBodyType:(RequestBodyType *)requestBodyType
                       responseDataType:(ResponseDataType *)responseDataType;

@end
