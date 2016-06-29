//
//  AbsResponseDataSerializer.h
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/3/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbsResponseDataSerializer : NSObject

/**
 *  处理返回的参数
 *
 *  @param data 处理前的参数
 *
 *  @return 处理后的参数
 */
- (id)serializeResponseData:(id)data;

@end
