//
//  NetworkingReachability.h
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  外部接收通知用字符串
 */
extern NSString *const NetworkingReachableViaWWANNotification;
extern NSString *const NetworkingReachableViaWIFINotification;
extern NSString *const NetworkingNotReachableNotification;

@interface NetworkingReachability : NSObject

/**
 *  开始监听网络状态
 */
+ (void)startMonitoring;

/**
 *  结束监听网络状态
 */
+ (void)stopMonitoring;

/**
 *  是否可以联网
 *
 *  @return YES为可以,NO为不行
 */
+ (BOOL)isReachable;

/**
 *  当前是否是WWAN网络
 *
 *  @return YES为是,NO为不是
 */
+ (BOOL)isReachableViaWWAN;

/**
 *  当前是否为WIFI网络
 *
 *  @return YES为是,NO为不是
 */
+ (BOOL)isReachableViaWiFi;

@end
