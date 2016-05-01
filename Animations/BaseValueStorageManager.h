//
//  BaseValueStorageManager.h
//  ValueStorageManager
//
//  Created by YouXianMing on 16/3/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbsEncryptingMode.h"

@interface BaseValueStorageManager : NSObject

/**
 *  Config the encryptingMode object and properties prefix, you should run this method first.
 *
 *  @param encryptingMode EncryptingMode object.
 *  @param prefix         Prefix string.
 */
+ (void)configEncryptingMode:(AbsEncryptingMode *)encryptingMode prefix:(NSString *)prefix;

/**
 *  Get the shared instance.
 *
 *  @return Shared instance.
 */
+ (instancetype)sharedInstance;

@end
