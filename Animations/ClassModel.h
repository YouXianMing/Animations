//
//  ClassModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "StudentModel.h"

@interface ClassModel : NSObject

@property (nonatomic, strong) NSString                  *className;
@property (nonatomic, strong) NSArray  <StudentModel *> *students;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

#pragma mark - 额外的数据
@property (nonatomic) BOOL  expend;

@end

