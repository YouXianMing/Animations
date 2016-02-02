//
//  UserModel.m
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import "UserModel.h"

@implementation UserModel

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
        
        self.userId = value;
        return;
    }
    
    if ([key isEqualToString:@"description"]) {
        
        self.infomation = value;
        return;
    }    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    // ignore null value
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
    }
    // avatar_image
    if ([key isEqualToString:@"avatar_image"] && [value isKindOfClass:[NSDictionary class]]) {
        
        value = [[AvatarImageModel alloc] initWithDictionary:value];
    }

    // counts
    if ([key isEqualToString:@"counts"] && [value isKindOfClass:[NSDictionary class]]) {
        
        value = [[CountsModel alloc] initWithDictionary:value];
    }

    // description
    if ([key isEqualToString:@"description"] && [value isKindOfClass:[NSDictionary class]]) {
        
        value = [[DescriptionModel alloc] initWithDictionary:value];
    }

    // cover_image
    if ([key isEqualToString:@"cover_image"] && [value isKindOfClass:[NSDictionary class]]) {
        
        value = [[CoverImageModel alloc] initWithDictionary:value];
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

