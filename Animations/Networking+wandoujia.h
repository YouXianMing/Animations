//
//  Networking+wandoujia.h
//  Animations
//
//  Created by YouXianMing on 2017/8/21.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "Networking.h"

static NSString *baseURL = @"http://baobab.wandoujia.com";

typedef enum : NSUInteger {
    
    kFeed = 1000,
    
} ENetworkConfigTagValue;

#pragma mark - NetworkConfig

@interface NetworkConfig : NSObject

@property (nonatomic, strong) NSString           *urlString;
@property (nonatomic, strong) NSString           *functionName;
@property (nonatomic)         NSInteger           tag;
@property (nonatomic)         ENetworkingMethod   method;

@end

/**
 *  [GET] 豌豆荚图片列表请求 (/api/v1/feed)
 */
static inline NetworkConfig *feed() {
    
    NetworkConfig *config = [NetworkConfig new];
    config.urlString      = [baseURL stringByAppendingString:@"/api/v1/feed"];
    config.functionName   = @"豌豆荚图片列表请求";
    config.tag            = kFeed;
    config.method         = kNetworkingGET;
    
    return config;
}

#pragma mark - Networking's category

@interface Networking (wandoujia)

+ (instancetype)networkingWithNetworkConfig:(NetworkConfig *)config requestParameter:(id)requestParameter delegate:(id <NetworkingDelegate>)delegate;

@end
