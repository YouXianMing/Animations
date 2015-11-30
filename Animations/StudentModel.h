//
//  StudentModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>

@interface StudentModel : NSObject

@property (nonatomic, strong) NSString       *name;
@property (nonatomic, strong) NSNumber       *age;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

