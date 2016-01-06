//
//  RequestDictionarySerializer.h
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//

#import <Foundation/Foundation.h>

@protocol RequestDictionarySerializer <NSObject>

/**
 *  处理请求的字典
 *
 *  @param requestDictionary 请求字典
 *
 *  @return 处理后的字典数据
 */
- (NSDictionary *)serializeRequestDictionary:(NSDictionary *)requestDictionary;

@end
