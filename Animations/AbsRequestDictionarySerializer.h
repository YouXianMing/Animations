//
//  AbsRequestDictionarySerializer.h
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/3/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbsRequestDictionarySerializer : NSObject

/**
 *  处理请求的字典
 *
 *  @param requestDictionary 请求字典
 *
 *  @return 处理后的字典数据
 */
- (NSDictionary *)serializeRequestDictionary:(NSDictionary *)requestDictionary;

@end
