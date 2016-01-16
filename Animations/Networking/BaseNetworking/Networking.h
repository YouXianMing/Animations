//
//  Networking.h
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//

#import <Foundation/Foundation.h>
#import "RequestDictionarySerializer.h"
#import "ResponseDataSerializer.h"
#import "RequestBodyType.h"
#import "RequestMethodType.h"
#import "ResponseDataType.h"

@class Networking;

@protocol NetworkingDelegate <NSObject>

/**
 *  请求成功
 *
 *  @param networking networking对象
 *  @param data       数据
 */
- (void)requestSucess:(Networking *)networking data:(id)data;

/**
 *  请求失败
 *
 *  @param networking networking对象
 *  @param error      错误信息
 */
- (void)requestFailed:(Networking *)networking error:(NSError *)error;

@end

@interface Networking : NSObject

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
 *  请求类型
 */
@property (nonatomic, strong)   RequestBodyType   *requestBodyType;

/**
 *  设置请求头部信息
 */
@property (nonatomic, strong)   NSDictionary      *HTTPHeaderFieldsWithValues;

/**
 *  回复类型
 */
@property (nonatomic, strong)   ResponseDataType  *responseDataType;

/**
 *  代理
 */
@property (nonatomic, weak)     id <NetworkingDelegate> delegate;

/**
 *  请求用字典
 */
@property (nonatomic, strong)   NSDictionary *requestDictionary;

/**
 *  请求标记
 */
@property (nonatomic)           NSInteger tag;

/**
 *  处理请求字典参数
 */
@property (nonatomic, strong)   id <RequestDictionarySerializer> requestDictionarySerializer;

/**
 *  请求超时时间间隔（不设置的话默认值为5s）
 */
@property (nonatomic, strong)   NSNumber *timeoutInterval;

/**
 *  处理返回的数据
 */
@property (nonatomic, strong)   id <ResponseDataSerializer> responseDataSerializer;

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
 *  @param requestDictionary 请求字典
 *  @param requestBodyType   请求包体类型
 *  @param responseDataType  回复数据类型
 *
 *  @return Networking对象
 */
+ (id)getMethodNetworkingWithUrlString:(NSString *)urlString
                     requestDictionary:(NSDictionary *)requestDictionary
                       requestBodyType:(RequestBodyType *)requestBodyType
                      responseDataType:(ResponseDataType *)responseDataType;

/**
 *  POST请求
 *
 *  @param urlString         网址
 *  @param requestDictionary 请求字典
 *  @param requestBodyType   请求包体类型
 *  @param responseDataType  回复数据类型
 *
 *  @return Networking对象
 */
+ (id)postMethodNetworkingWithUrlString:(NSString *)urlString
                      requestDictionary:(NSDictionary *)requestDictionary
                        requestBodyType:(RequestBodyType *)requestBodyType
                       responseDataType:(ResponseDataType *)responseDataType;

@end
