//
//  PickerCityDataManager.m
//  Animations
//
//  Created by YouXianMing on 2017/9/12.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "PickerCityDataManager.h"

@implementation PickerCityDataManager

+ (NSMutableArray <PickerProvinceModel *> *)provinceModelsWithArray:(NSArray *)array {
    
    NSMutableArray *provinces = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *provinceData, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PickerProvinceModel *province = [PickerProvinceModel new];
        province.province             = provinceData[@"name"];
        province.cities               = [NSMutableArray array];
        [provinces addObject:province];
        
        NSArray *cities = provinceData[@"city"];
        [cities enumerateObjectsUsingBlock:^(NSDictionary *cityData, NSUInteger idx, BOOL * _Nonnull stop) {
            
            PickerCityModel *city = [PickerCityModel new];
            city.city             = cityData[@"name"];
            city.areas            = [NSMutableArray array];
            [province.cities addObject:city];
            
            NSArray *areas = cityData[@"area"];
            [areas enumerateObjectsUsingBlock:^(NSString *areaString, NSUInteger idx, BOOL * _Nonnull stop) {
                
                PickerAreaModel *area = [PickerAreaModel new];
                area.area             = areaString;
                [city.areas addObject:area];
            }];
        }];
    }];
    
    return provinces;
}

@end
