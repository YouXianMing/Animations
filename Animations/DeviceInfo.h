//
//  DeviceInfo.h
//  Animations
//
//  Created by YouXianMing on 2018/8/17.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    /**
     iPhone4 or iPhone4s
     */
    Device_320x480,
    
    /**
     iPhone5 or iPhone5s or iPhoneSE
     */
    Device_320x568,
    
    /**
     iPhone6 or iPhone6s or iPhone 7 or iPhone 8
     */
    Device_375x667,
    
    /**
     iPhone6Plus or iPhone6sPlus or iPhone7sPlus or iPhone8sPlus
     */
    Device_414x736,
    
    /**
     iPhoneX
     */
    Device_375x812,
    
    /**
     New device type not added.
     */
    Device_Not_Added,
    
} DeviceType;

@interface DeviceInfo : NSObject

/**
 获取设备尺寸枚举值
 */
@property (class, nonatomic, readonly) DeviceType deviceType;

/**
 是否是刘海屏幕
 */
@property (class, nonatomic, readonly) BOOL isFringeScreen;

/**
 刘海屏顶部安全距离(如果不是刘海屏幕,则安全高度为0)
 */
@property (class, nonatomic, readonly) CGFloat fringeScreenTopSafeHeight;

/**
 刘海屏底部安全距离(如果不是刘海屏幕,则安全高度为0)
 */
@property (class, nonatomic, readonly) CGFloat fringeScreenBottomSafeHeight;

/**
 获取设备版本号,比如 iPhone X, iPad Air 2
 */
@property (class, nonatomic, readonly) NSString *deviceName;

/**
 获取用户关于本机中的名称,比如 YouXianMing's iPhone
 */
@property (class, nonatomic, readonly) NSString *userDeviceName;

/**
 获取app版本,比如 1.0
 */
@property (class, nonatomic, readonly) NSString *appVersion;

/**
 当前系统名称,比如 iOS
 */
@property (class, nonatomic, readonly) NSString *systemName;

/**
 当前系统版本,比如 11.4
 */
@property (class, nonatomic, readonly) NSString *systemVersion;

/**
 获取当前设备IP地址,获取不到时返回空
 */
@property (class, nonatomic, readonly) NSString *IPAddress;

/**
 获取当前wifi名字
 */
@property (class, nonatomic, readonly) NSString *wifiName;

/**
 获取总内存大小,拿结果除以1024三次后就是G为单位
 */
@property (class, nonatomic, readonly) long long physicalMemory;

/**
 当前可用内存,拿结果除以1024三次后就是G为单位
 */
@property (class, nonatomic, readonly) long long availableMemory;

/**
 获取当前设备的语言
 */
@property (class, nonatomic, readonly) NSString *deviceLanguage;

@end
