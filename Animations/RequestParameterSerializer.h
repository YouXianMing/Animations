//
//  RequestParameterSerializer.h
//  Networking
//
//  Created by YouXianMing on 2017/8/18.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestParameterSerializer : NSObject

/**
 *  处理请求参数
 *
 *  @param requestParameter 请求参数
 *
 *  @return 处理后的参数
 */
- (id)serializeRequestParameter:(id)requestParameter;

@end
