//
//  RequestBodyType.h
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//

#import <Foundation/Foundation.h>

@interface RequestBodyType : NSObject

+ (instancetype)type;

@end

@interface HttpBodyType : RequestBodyType

@end

@interface JsonBodyType : RequestBodyType

@end

@interface PlistBodyType : RequestBodyType

@end