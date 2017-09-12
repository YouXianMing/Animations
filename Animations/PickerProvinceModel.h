//
//  PickerProvinceModel.h
//  Animations
//
//  Created by YouXianMing on 2017/9/12.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerCityModel.h"

@interface PickerProvinceModel : NSObject

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSMutableArray <PickerCityModel *> *cities;

@end
