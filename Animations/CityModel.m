//
//  CityModel.m
//  TreeTableView
//
//  Created by YouXianMing on 2017/7/23.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CityModel.h"

@interface CityModel ()

@property (nonatomic, strong) NSMutableArray <CityModel *>  *allSubmodels;

@end

@implementation CityModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    // ignore null value
    if ([value isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    // level
    if ([key isEqualToString:@"level"]) {
        
        _level = [value integerValue];
        return;
    }
    
    // submodels (递归调用初始化)
    if ([key isEqualToString:@"submodels"]) {
        
        NSMutableArray *datas     = [NSMutableArray array];
        NSArray        *submodels = value;
        [submodels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CityModel *model = [[CityModel alloc] initWithDictionary:obj];
            [datas addObject:model];
        }];
        
        value = datas;
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

/**
 如果extend参数为NO,则没有submodels

 @return submodels
 */
- (NSMutableArray<CityModel *> *)submodels {
    
    return _extend ? _submodels : [NSMutableArray array];
}

/**
 递归调用(核心)

 @param model CityModel实体
 @param array 存储数据用的数组
 */
- (void)storeSubmodels:(CityModel *)model array:(NSMutableArray *)array {
 
    [model.submodels enumerateObjectsUsingBlock:^(CityModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [array addObject:obj];
        [model storeSubmodels:obj array:array];
    }];
}

- (NSMutableArray<CityModel *> *)allSubmodels {
    
    NSMutableArray *array = [NSMutableArray array];
    [self storeSubmodels:self array:array];
    
    return array;
}

- (NSInteger)submodelsCount {
    
    return _submodels.count;
}

@end
