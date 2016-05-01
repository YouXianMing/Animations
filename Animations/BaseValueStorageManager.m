//
//  BaseValueStorageManager.m
//  ValueStorageManager
//
//  Created by YouXianMing on 16/3/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BaseValueStorageManager.h"
#import "FastCoder.h"
#import <objc/runtime.h>

static NSMutableDictionary  *_dictionary = nil;

@interface BaseValueStorageManager ()

@property (nonatomic, strong) NSArray            *baseValueStorageManagerProperties;
@property (nonatomic, strong) AbsEncryptingMode  *baseValueStorageManagerEncryptingMode;
@property (nonatomic, strong) NSString           *baseValueStorageManagerPrifixName;

@end

@implementation BaseValueStorageManager

+ (void)initialize {
    
    if (self == [BaseValueStorageManager class]) {
        
        _dictionary = [NSMutableDictionary dictionary];
    }
}

+ (void)configEncryptingMode:(AbsEncryptingMode *)encryptingMode prefix:(NSString *)prefix {
    
    BaseValueStorageManager *newObject              = [[[self class] alloc] init];
    newObject.baseValueStorageManagerEncryptingMode = (encryptingMode == nil ? [AbsEncryptingMode new]         : encryptingMode);
    newObject.baseValueStorageManagerPrifixName     = (prefix         == nil ? NSStringFromClass([self class]) : prefix);
    
    // Get all useful properties.
    NSArray        *allProperties    = [newObject allProperties];
    NSMutableArray *usefulProperties = [NSMutableArray array];
    for (int i = 0; i < allProperties.count; i++) {
        
        NSString *propertyName = allProperties[i];
        if ([propertyName isEqualToString:@"baseValueStorageManagerProperties"] ||
            [propertyName isEqualToString:@"baseValueStorageManagerEncryptingMode"] ||
            [propertyName isEqualToString:@"baseValueStorageManagerPrifixName"]) {
            
            continue;
        }
        
        [usefulProperties addObject:propertyName];
    }
    newObject.baseValueStorageManagerProperties = [NSArray arrayWithArray:usefulProperties];
    
    [_dictionary setObject:newObject forKey:NSStringFromClass([self class])];
    
    // Set all the properties.
    for (int i = 0; i < allProperties.count; i++) {
        
        NSString *key     = allProperties[i];
        NSString *keyPath = [newObject addPrifixWithString:key prifix:newObject.baseValueStorageManagerPrifixName];
        id object         = [[NSUserDefaults standardUserDefaults] objectForKey:keyPath];
        
        if (object) {
            
            object = [FastCoder objectWithData:[newObject.baseValueStorageManagerEncryptingMode decryptData:object]];
            [newObject setValue:object forKey:key];
        }
    }
    
    // KVO
    for (int i = 0; i < newObject.baseValueStorageManagerProperties.count; i++) {
        
        [newObject addObserver:newObject forKeyPath:newObject.baseValueStorageManagerProperties[i]
                       options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (NSString *)addPrifixWithString:(NSString *)string prifix:(NSString *)prefix {
    
    return [NSString stringWithFormat:@"_%@_%@", prefix, string];
}

+ (instancetype)sharedInstance {
    
    return _dictionary[NSStringFromClass([self class])];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    BaseValueStorageManager *manager    = object;
    NSString                *newKeyPath = [manager addPrifixWithString:keyPath prifix:_baseValueStorageManagerPrifixName];
    id                       newValue   = [_baseValueStorageManagerEncryptingMode encryptData:[FastCoder dataWithRootObject:[change[@"new"] isKindOfClass:[NSNull class]] ? nil : change[@"new"]]];
    [[NSUserDefaults standardUserDefaults] setObject:newValue forKey:newKeyPath];
}

/**
 *  Get all properties.
 *
 *  @return Properties array.
 */
- (NSArray *)allProperties {
    
    u_int count;
    objc_property_t *properties      = class_copyPropertyList([self class], &count);
    NSMutableArray  *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i<count; i++) {
        
        const char *propertyName = property_getName(properties[i]);
        [propertiesArray addObject:[NSString stringWithUTF8String: propertyName]];
    }
    
    free(properties);
    
    return propertiesArray;
}

- (void)dealloc {
    
    for (int i = 0; i < self.baseValueStorageManagerProperties.count; i++) {
        
        [self removeObserver:self forKeyPath:self.baseValueStorageManagerProperties[i]];
    }
}

@end
