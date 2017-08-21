//
//  NetworkingInfo.h
//  Networking
//
//  Created by YouXianMing on 2017/8/18.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Networking;

@interface NetworkingInfo : NSObject

@property (nonatomic, weak) Networking *networking;

/**
 *  显示信息
 */
- (void)showMessage;

@end
