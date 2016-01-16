//
//  Networking.m
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//

#import "Networking.h"

@implementation Networking

- (void)startRequest {

    [NSException raise:@"Networking startRequest"
                format:@"You must override this method."];
}

- (void)cancelRequest {

    [NSException raise:@"Networking cancelRequest"
                format:@"You must override this method."];
}

+ (id)getMethodNetworkingWithUrlString:(NSString *)urlString
                     requestDictionary:(NSDictionary *)requestDictionary
                       requestBodyType:(RequestBodyType *)requestBodyType
                      responseDataType:(ResponseDataType *)responseDataType {

    [NSException raise:@"Networking getMethodNetworkingWithUrlString:requestDictionary:requestBodyType:responseDataType:"
                format:@"You must override this method."];
    
    return nil;
}

+ (id)postMethodNetworkingWithUrlString:(NSString *)urlString
                      requestDictionary:(NSDictionary *)requestDictionary
                        requestBodyType:(RequestBodyType *)requestBodyType
                       responseDataType:(ResponseDataType *)responseDataType {

    [NSException raise:@"Networking postMethodNetworkingWithUrlString:requestDictionary:requestBodyType:responseDataType:"
                format:@"You must override this method."];
    
    return nil;
}

@end
