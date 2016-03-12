//
//  AbsNetworkingIndicator.h
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/3/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbsNetworkingIndicator : NSObject

/**
 *  是否显示网络加载指示器
 *
 *  @param show 是否显示
 */
+ (void)showNetworkActivityIndicator:(BOOL)show;

@end
