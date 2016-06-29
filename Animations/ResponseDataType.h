//
//  ResponseDataType.h
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//

#import <Foundation/Foundation.h>

@interface ResponseDataType : NSObject

+ (instancetype)type;

@end

@interface JsonDataType : ResponseDataType

@end

@interface HttpDataType : ResponseDataType

@end