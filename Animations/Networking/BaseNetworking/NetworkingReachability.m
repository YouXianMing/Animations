//
//  NetworkingReachability.m
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "NetworkingReachability.h"

NSString *const NetworkingReachableViaWWANNotification = @"NetworkingReachableViaWWAN";
NSString *const NetworkingReachableViaWIFINotification = @"NetworkingReachableViaWIFI";
NSString *const NetworkingNotReachableNotification     = @"NetworkingNotReachable";

@implementation NetworkingReachability

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
