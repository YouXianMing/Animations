//
//  BaseUserDefaults.m
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/4.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "BaseUserDefaults.h"

@implementation BaseUserDefaults

+ (id)getDataWithKey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] valueForKey:[BaseUserDefaults accessKey:key]];
}

+ (void)setData:(id)data withKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[BaseUserDefaults accessKey:key]];
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:[BaseUserDefaults accessKey:key]];
}

+ (void)setFloat:(float)value forKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:[BaseUserDefaults accessKey:key]];
}

+ (void)setDouble:(double)value forKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setDouble:value forKey:[BaseUserDefaults accessKey:key]];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:[BaseUserDefaults accessKey:key]];
}

+ (void)setURL:(NSURL *)url forKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setURL:url forKey:[BaseUserDefaults accessKey:key]];
}

+ (NSInteger)integerForKey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] integerForKey:[BaseUserDefaults accessKey:key]];
}

+ (float)floatForKey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] floatForKey:[BaseUserDefaults accessKey:key]];
}

+ (double)doubleForKey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] doubleForKey:[BaseUserDefaults accessKey:key]];
}

+ (BOOL)boolForKey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:[BaseUserDefaults accessKey:key]];
}

+ (NSURL *)URLForKey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] URLForKey:[BaseUserDefaults accessKey:key]];
}

#pragma mark - Private

+ (NSString *)accessKey:(NSString *)key {
    
    return [NSString stringWithFormat:@"%@-%@", NSStringFromClass([self class]), key];
}

@end
