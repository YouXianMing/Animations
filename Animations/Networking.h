//
//  Networking.h
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/3/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AbsNetworking.h"
#import "AFURLRequestSerialization.h"

typedef void(^AFNetworkingConstructingBodyBlock)(id<AFMultipartFormData> formData);

@interface Networking : AbsNetworking

+ (id)uploadMethodNetworkingWithUrlString:(NSString *)urlString
                         requestParameter:(id)requestParameter
                          requestBodyType:(RequestBodyType *)requestBodyType
                         responseDataType:(ResponseDataType *)responseDataType
                constructingBodyWithBlock:(AFNetworkingConstructingBodyBlock)constructingBodyBlock
                                 progress:(UploadProgressBlock)uploadProgressBlock;

@end
