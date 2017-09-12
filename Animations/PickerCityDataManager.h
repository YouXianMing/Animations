//
//  PickerCityDataManager.h
//  Animations
//
//  Created by YouXianMing on 2017/9/12.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerProvinceModel.h"

@interface PickerCityDataManager : NSObject

+ (NSMutableArray <PickerProvinceModel *> *)provinceModelsWithArray:(NSArray *)array;

@end
