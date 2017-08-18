//
//  ResponseDataSerializer.h
//  Networking
//
//  Created by YouXianMing on 2017/8/18.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseDataSerializer : NSObject

/**
 *  处理返回的参数
 *
 *  @param data 处理前的参数
 *
 *  @return 处理后的参数
 */
- (id)serializeResponseData:(id)data;

@end
