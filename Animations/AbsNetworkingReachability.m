//
//  AbsNetworkingReachability.m
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/3/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AbsNetworkingReachability.h"

NSString *const NetworkingReachableViaWWANNotification = @"NetworkingReachableViaWWAN";
NSString *const NetworkingReachableViaWIFINotification = @"NetworkingReachableViaWIFI";
NSString *const NetworkingNotReachableNotification     = @"NetworkingNotReachable";

@implementation AbsNetworkingReachability

+ (void)startMonitoring {
    
    [NSException raise:@"NetworkingReachability startMonitoring:"
                format:@"You must override this method."];
}

+ (void)stopMonitoring {
    
    [NSException raise:@"NetworkingReachability stopMonitoring:"
                format:@"You must override this method."];
}

+ (BOOL)isReachable {
    
    [NSException raise:@"NetworkingReachability isReachable:"
                format:@"You must override this method."];
    
    return NO;
}

+ (BOOL)isReachableViaWWAN {
    
    [NSException raise:@"NetworkingReachability isReachableViaWWAN:"
                format:@"You must override this method."];
    
    return NO;
}

+ (BOOL)isReachableViaWiFi {
    
    [NSException raise:@"NetworkingReachability isReachableViaWiFi:"
                format:@"You must override this method."];
    
    return NO;
}

@end
