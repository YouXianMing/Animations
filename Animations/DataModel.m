//
//  DataModel.m
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import "DataModel.h"

@implementation DataModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    /*  [Example] change property id to productID
     *
     *  if([key isEqualToString:@"id"]) {
     *
     *      self.productID = value;
     *      return;
     *  }
     */
    
    if ([key isEqualToString:@"id"]) {
        
        self.dataId = value;
        return;
    }    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    // ignore null value
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
    }
    // user
    if ([key isEqualToString:@"user"] && [value isKindOfClass:[NSDictionary class]]) {
        
        value = [[UserModel alloc] initWithDictionary:value];
    }

    // entities
    if ([key isEqualToString:@"entities"] && [value isKindOfClass:[NSDictionary class]]) {
        
        value = [[EntitiesModel alloc] initWithDictionary:value];
    }

    // source
    if ([key isEqualToString:@"source"] && [value isKindOfClass:[NSDictionary class]]) {
        
        value = [[SourceModel alloc] initWithDictionary:value];
    }


    [super setValue:value forKey:key];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        
        if (self = [super init]) {
            
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    
    return self;
}

@end

