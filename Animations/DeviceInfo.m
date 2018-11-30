//
//  DeviceInfo.m
//  Animations
//
//  Created by YouXianMing on 2018/8/17.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "DeviceInfo.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <mach/mach.h>

@implementation DeviceInfo

+ (DeviceType)deviceType {
    
    static DeviceType type;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        CGFloat width  = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        
        if (width == 320.f && height == 480.f) {
            
            type = Device_320x480;
            
        } else if (width == 320.f && height == 568.f) {
            
            type = Device_320x568;
            
        } else if (width == 375.f && height == 667.f) {
            
            type = Device_375x667;
            
        } else if (width == 414.f && height == 736.f) {
            
            type = Device_414x736;
            
        } else if (width == 375.f && height == 812.f) {
            
            type = Device_375x812;
            
        } else {
            
            type = Device_Not_Added;
        }
    });
    
    return type;
}

+ (BOOL)isFringeScreen {
    
    static BOOL isFringeScreen = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        if (DeviceInfo.deviceType == Device_375x812) {
            
            isFringeScreen = YES;
        }
    });
    
    return isFringeScreen;
}

+ (CGFloat)fringeScreenTopSafeHeight {
    
    static CGFloat height = 0;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (DeviceInfo.deviceType == Device_375x812) {
            
            height = 44.f;
        }
    });
    
    return height;
}

+ (CGFloat)fringeScreenBottomSafeHeight {
    
    static CGFloat height = 0;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (DeviceInfo.deviceType == Device_375x812) {
            
            height = 34.f;
        }
    });
    
    return height;
}

+ (NSString *)deviceName {
    
    static NSString *retVal = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 请查阅 https://www.theiphonewiki.com/wiki/Models 更新设备号
        
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *devStr = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        
        // iPhone
        if      ([DeviceInfo devStr:devStr equalTo:@[@"iPhone1,1"]])                             retVal = @"iPhone";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone1,2"]])                             retVal = @"iPhone 3G";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone2,1"]])                             retVal = @"iPhone 3GS";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone3,1", @"iPhone3,2", @"iPhone3,3"]]) retVal = @"iPhone 4";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone4,1"]])                             retVal = @"iPhone 4S";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone5,1", @"iPhone5,2"]])               retVal = @"iPhone 5";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone5,3", @"iPhone5,4"]])               retVal = @"iPhone 5c";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone6,1", @"iPhone6,2"]])               retVal = @"iPhone 5s";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone7,2"]])                             retVal = @"iPhone 6";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone7,1"]])                             retVal = @"iPhone 6 Plus";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone8,1"]])                             retVal = @"iPhone 6s";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone8,2"]])                             retVal = @"iPhone 6s Plus";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone8,4"]])                             retVal = @"iPhone SE";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone9,1", @"iPhone9,3"]])               retVal = @"iPhone 7";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone9,2", @"iPhone9,4"]])               retVal = @"iPhone 7 Plus";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone10,1", @"iPhone10,4"]])             retVal = @"iPhone 8";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone10,2", @"iPhone10,5"]])             retVal = @"iPhone 8 Plus";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone10,3", @"iPhone10,6"]])             retVal = @"iPhone X";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone11,8"]])                            retVal = @"iPhone XR";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone11,2"]])                            retVal = @"iPhone XS";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPhone11,4", @"iPhone11,6"]])             retVal = @"iPhone XS Max";
        
        // iPod
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPod1,1"]])             retVal = @"iPod touch";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPod2,1"]])             retVal = @"iPod touch (2nd generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPod3,1"]])             retVal = @"iPod touch (3rd generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPod4,1"]])             retVal = @"iPod touch (4th generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPod5,1"]])             retVal = @"iPod touch (5th generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPod7,1"]])             retVal = @"iPod touch (6th generation)";
        
        // iPad
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad1,1"]])                                     retVal = @"iPad";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad2,1", @"iPad2,2", @"iPad2,3", @"iPad2,4"]]) retVal = @"iPad 2";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad3,1", @"iPad3,2", @"iPad3,3"]])             retVal = @"iPad (3rd generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad3,4", @"iPad3,5", @"iPad3,6"]])             retVal = @"iPad (4th generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad4,1", @"iPad4,2", @"iPad4,3"]])             retVal = @"iPad Air";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad5,3", @"iPad5,4"]])                         retVal = @"iPad Air 2";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad6,7", @"iPad6,8"]])                         retVal = @"iPad Pro (12.9-inch)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad6,3", @"iPad6,4"]])                         retVal = @"iPad Pro (9.7-inch)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad6,11", @"iPad6,12"]])                       retVal = @"iPad (5th generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad7,1", @"iPad7,2"]])                         retVal = @"iPad Pro (12.9-inch, 2nd generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad7,3", @"iPad7,4"]])                         retVal = @"iPad Pro (10.5-inch)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad7,5", @"iPad7,6"]])                         retVal = @"iPad (6th generation)";
        
        // iPad mini
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad2,5", @"iPad2,6", @"iPad2,7"]]) retVal = @"iPad mini";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad4,4", @"iPad4,5", @"iPad4,6"]]) retVal = @"iPad mini 2";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad4,7", @"iPad4,8", @"iPad4,9"]]) retVal = @"iPad mini 3";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"iPad5,1", @"iPad5,2"]])             retVal = @"iPad mini 4";
        
        // HomePod
        else if ([DeviceInfo devStr:devStr equalTo:@[@"AudioAccessory1,1", @"AudioAccessory1,2"]]) retVal = @"HomePod";
        
        // AirPods
        else if ([DeviceInfo devStr:devStr equalTo:@[@"AirPods1,1"]]) retVal = @"AirPods";
        
        // Apple Watch
        else if ([DeviceInfo devStr:devStr equalTo:@[@"Watch1,1", @"Watch1,2"]])                           retVal = @"Apple Watch (1st generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"Watch2,6", @"Watch2,7"]])                           retVal = @"Apple Watch Series 1";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"Watch2,3", @"Watch2,4"]])                           retVal = @"Apple Watch Series 2";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"Watch3,1", @"Watch3,2", @"Watch3,3", @"Watch3,4"]]) retVal = @"Apple Watch Series 3";
        
        // Apple TV
        else if ([DeviceInfo devStr:devStr equalTo:@[@"AppleTV2,1"]])                retVal = @"Apple TV (2nd generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"AppleTV3,1", @"AppleTV3,2"]]) retVal = @"Apple TV (3rd generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"AppleTV5,3"]])                retVal = @"Apple TV (4th generation)";
        else if ([DeviceInfo devStr:devStr equalTo:@[@"AppleTV6,2"]])                retVal = @"Apple TV 4K";
        
        // Simulator
        else if ([DeviceInfo devStr:devStr equalTo:@[@"i386", @"x86_64"]]) retVal = @"Simulator";
        
        // New device.
        else retVal = devStr;
    });
    
    return retVal;
}

+ (NSString *)userDeviceName {
    
    return [UIDevice currentDevice].name;
}

+ (NSString *)appVersion {
    
    return [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)systemName {
    
    return UIDevice.currentDevice.systemName;
}

+ (NSString *)systemVersion {
    
    return UIDevice.currentDevice.systemVersion;
}

+ (NSString *)IPAddress {
    
    int success                = 0;
    NSString *address          = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr  = NULL;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) {
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    return address;
}

+ (NSString *)wifiName {
    
    NSString  *wifiName       = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (wifiInterfaces == nil) {
        
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    
    return wifiName;
}

+ (long long)physicalMemory {
    
    return NSProcessInfo.processInfo.physicalMemory;
}

+ (long long)availableMemory {
    
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

+ (NSString *)deviceLanguage {
        
    return NSLocale.preferredLanguages.firstObject;
}

#pragma mark - private methods.

+ (BOOL)devStr:(NSString *)devStr equalTo:(NSArray <NSString *> *)array {
    
    __block BOOL equal = NO;
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([devStr isEqualToString:obj]) {
            
            equal = YES;
            *stop = YES;
        }
    }];
    
    return equal;
}

@end






