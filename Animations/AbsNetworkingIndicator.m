//
//  AbsNetworkingIndicator.m
//  AFNetworking-3.x
//
//  Created by YouXianMing on 16/3/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AbsNetworkingIndicator.h"

@implementation AbsNetworkingIndicator

+ (void)showNetworkActivityIndicator:(BOOL)show {
    
    [NSException raise:@"NetworkingIndicator showNetworkActivityIndicator:"
                format:@"You must override this method."];
}

@end
