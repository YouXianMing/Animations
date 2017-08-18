//
//  NetworkingInfo.h
//  Networking
//
//  Created by YouXianMing on 2017/8/18.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXNetworking;

@interface NetworkingInfo : NSObject

@property (nonatomic, weak) YXNetworking *networking;

/**
 *  显示信息
 */
- (void)showMessage;

@end
