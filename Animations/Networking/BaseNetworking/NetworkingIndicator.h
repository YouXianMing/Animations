//
//  NetworkingIndicator.h
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingIndicator : NSObject

/**
 *  是否显示网络加载指示器
 *
 *  @param show 是否显示
 */
+ (void)showNetworkActivityIndicator:(BOOL)show;

@end
