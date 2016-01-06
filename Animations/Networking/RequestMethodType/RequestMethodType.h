//
//  RequestMethodType.h
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//

#import <Foundation/Foundation.h>

@interface RequestMethodType : NSObject

+ (instancetype)type;

@end

@interface GetMethod : RequestMethodType

@end

@interface PostMethod : RequestMethodType

@end