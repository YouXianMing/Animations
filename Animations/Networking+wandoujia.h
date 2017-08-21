//
//  Networking+wandoujia.h
//  Animations
//
//  Created by YouXianMing on 2017/8/21.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "Networking.h"

@interface Networking (wandoujia)

+ (instancetype)networkingWithUrlString:(NSString *)urlString
                       requestParameter:(id)requestParameter
                            serviceInfo:(NSString *)serviceInfo
                               delegate:(id <NetworkingDelegate>)delegate;

@end
