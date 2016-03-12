//
//  NetworkingIndicator.m
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/3/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "NetworkingIndicator.h"
#import "UIKit+AFNetworking.h"

@implementation NetworkingIndicator

+ (void)showNetworkActivityIndicator:(BOOL)show {
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:show];
}

@end
