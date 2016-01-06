//
//  V_2_X_NetworkingIndicator.m
//  Networking
//
//  Created by YouXianMing on 15/11/6.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "V_2_X_NetworkingIndicator.h"
#import "UIKit+AFNetworking.h"

@implementation V_2_X_NetworkingIndicator

+ (void)showNetworkActivityIndicator:(BOOL)show {

    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:show];
}

@end
