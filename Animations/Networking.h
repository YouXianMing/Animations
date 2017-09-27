//
//  YXNetworking.h
//  Networking
//
//  Created by YouXianMing on 2017/8/18.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "RequestParameterSerializer.h"
#import "ResponseDataSerializer.h"
#import "ResponseDataManager.h"
#import "NetworkingInfo.h"
@class Networking;

typedef void (^ConstructingBodyBlock)(id <AFMultipartFormData> formData);
typedef void (^UploadProgressBlock)(NSProgress *uploadProgress);

typedef enum : NSUInteger {
    
    kNetworkingGET,
    kNetworkingPOST,
    kNetworkingUPLOAD,
    
} ENetworkingMethod;

@protocol NetworkingDelegate <NSObject>

/**
 *  请求成功
 *
 *  @param networking networking对象
 *  @param data       数据
 */
- (void)networkingRequestSucess:(Networking *)networking tag:(NSInteger)tag data:(id)data;

/**
 *  请求失败
 *
 *  @param networking networking对象
 *  @param error      错误信息
 */
- (void)networkingRequestFailed:(Networking *)networking tag:(NSInteger)tag error:(NSError *)error;

@end

@interface Networking : NSObject

/**
 *  代理
 */
@property (nonatomic, weak) id <NetworkingDelegate> delegate;

/**
 *  传值对象(传值使用)
 */
@property (nonatomic, weak) id object;

#pragma mark - 设置参数

/**
 *  请求类型设置,默认值为GET请求
 */
@property (nonatomic) ENetworkingMethod method;

/**
 *  网络请求地址（空网址直接崩溃）
 */
@property (nonatomic, strong) NSString *urlString;

/**
 *  请求用参数
 */
@property (nonatomic, strong) id requestParameter;

/**
 *  构造上传数据的block
 */
@property (nonatomic, copy) ConstructingBodyBlock constructingBodyBlock;

/**
 *  检测下载进度的block
 */
@property (nonatomic, copy) UploadProgressBlock uploadProgressBlock;

/**
 *  请求参数预处理策略
 */
@property (nonatomic, strong) RequestParameterSerializer *requestParameterSerializer;

/**
 *  回复数据处理策略
 */
@property (nonatomic, strong) ResponseDataSerializer *responseDataSerializer;

/**
 *  设置请求头部信息
 */
@property (nonatomic, strong) NSDictionary *HTTPHeaderFieldsWithValues;

/**
 *  请求序列化,可选值如下,默认值为 AFHTTPRequestSerializer
 *
 *  AFHTTPRequestSerializer
 *  AFJSONRequestSerializer
 *  AFPropertyListRequestSerializer
 */
@property (nonatomic, strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * requestSerializer;

/**
 *  回复序列化,可选值如下,默认值为 AFHTTPResponseSerializer
 *
 *  AFHTTPResponseSerializer
 *  AFJSONResponseSerializer
 *  AFXMLParserResponseSerializer
 *  AFXMLDocumentResponseSerializer
 *  AFPropertyListResponseSerializer
 *  AFImageResponseSerializer
 *  AFCompoundResponseSerializer
 */
@property (nonatomic, strong) AFHTTPResponseSerializer <AFURLResponseSerialization> * responseSerializer;

/**
 *  请求标记
 */
@property (nonatomic) NSInteger tag;

/**
 *  请求超时时间间隔（不设置的话默认值为5s）
 */
@property (nonatomic, strong) NSNumber *timeoutInterval;

#pragma mark - 运行时候的参数

/**
 *  是否正在请求当中
 */
@property (nonatomic) BOOL isRunning;

/**
 *  没有处理过的原始数据
 */
@property (nonatomic, strong) id originalResponseData;

/**
 *  处理过的原始数据
 */
@property (nonatomic, strong) id serializerResponseData;

#pragma mark - 请求方法

/**
 *  开始请求
 */
- (void)startRequest;

/**
 *  取消请求
 */
- (void)cancelRequest;

#pragma mark - 调试信息

/**
 *  服务信息
 */
@property (nonatomic, strong) NSString *serviceInfo;

/**
 *  调试信息
 */
@property (nonatomic, strong) NetworkingInfo *networkingInfo;

#pragma mark - 返回数据的预处理

/**
 *  返回数据的管理
 */
@property (nonatomic, strong) ResponseDataManager *responseDataManager;

#pragma mark - 菊花

/**
 *  是否显示旋转的菊花
 *
 *  @param show 是否显示旋转的菊花
 */
+ (void)showNetworkActivityIndicator:(BOOL)show;

#pragma mark - 便利构造器

/**
 *  请求的便利构造器
 *
 *  @param urlString                   网址
 *  @param requestParameter            请求参数
 *  @param method                      请求类型
 *  @param requestParameterSerializer  请求参数转换策略
 *  @param responseDataSerializer      回复数据转换策略
 *  @param constructingBodyBlock       构造body的block
 *  @param uploadProgressBlock         进度block
 *  @param tag                         tag值
 *  @param delegate                    代理
 *  @param requestSerializer           请求包体类型
 *  @param responseSerializer          回复数据类型
 *
 *  @return Networking对象
 */
+ (instancetype)networkingWithUrlString:(NSString *)urlString
                       requestParameter:(id)requestParameter
                                 method:(ENetworkingMethod)method
             requestParameterSerializer:(RequestParameterSerializer *)requestParameterSerializer
                 responseDataSerializer:(ResponseDataSerializer *)responseDataSerializer
              constructingBodyWithBlock:(ConstructingBodyBlock)constructingBodyBlock
                               progress:(UploadProgressBlock)uploadProgressBlock
                                    tag:(NSInteger)tag
                               delegate:(id <NetworkingDelegate>)delegate
                      requestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer
                     responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer;

@end
