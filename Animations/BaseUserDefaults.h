//
//  BaseUserDefaults.h
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/4.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseUserDefaults : NSObject

+ (id)getDataWithKey:(NSString *)key;

+ (void)setData:(id)data withKey:(NSString *)key;

#pragma mark - Get value.

+ (NSInteger)integerForKey:(NSString *)key;

+ (float)floatForKey:(NSString *)key;

+ (double)doubleForKey:(NSString *)key;

+ (BOOL)boolForKey:(NSString *)key;

+ (NSURL *)URLForKey:(NSString *)key;

#pragma mark - Set value.

+ (void)setInteger:(NSInteger)value forKey:(NSString *)key;

+ (void)setFloat:(float)value forKey:(NSString *)key;

+ (void)setDouble:(double)value forKey:(NSString *)key;

+ (void)setBool:(BOOL)value forKey:(NSString *)key;

+ (void)setURL:(NSURL *)url forKey:(NSString *)key;

@end
