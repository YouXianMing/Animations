//
//  RequestBodyType.m
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//

#import "RequestBodyType.h"

@implementation RequestBodyType

+ (instancetype)type {

    RequestBodyType *bodyType = [[[self class] alloc] init];
    return bodyType;
}

@end

@implementation HttpBodyType

@end

@implementation JsonBodyType

@end

@implementation PlistBodyType

@end
