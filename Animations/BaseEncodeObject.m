//
//  BaseEncodeObject.m
//  FamousQuotes
//
//  Created by YouXianMing on 2017/12/30.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "BaseEncodeObject.h"

@implementation BaseEncodeObject

- (NSData *)encodeData {
    
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

+ (instancetype)decodeWithData:(NSData *)data {
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

#pragma mark - AutoEncode

+ (NSArray <NSString *> *)autoEncodePropertyKeys {
    
    return nil;
}

- (void)autoEncodePropertiesWithCoder:(NSCoder *)aCoder class:(Class)aClass {
    
    [aClass.autoEncodePropertyKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }];
}

- (void)autoDecoderPropertiesWithDecoder:(NSCoder *)aDecoder class:(Class)aClass {
    
    [aClass.autoEncodePropertyKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
    }];
}

@end
