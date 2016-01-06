//
//  ResponseDataSerializer.h
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//

#import <Foundation/Foundation.h>

@protocol ResponseDataSerializer <NSObject>

/**
 *  处理返回的参数
 *
 *  @param data 处理前的参数
 *
 *  @return 处理后的参数
 */
- (id)serializeResponseData:(id)data;

@end
