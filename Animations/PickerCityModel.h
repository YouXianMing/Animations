//
//  PickerCityModel.h
//  Animations
//
//  Created by YouXianMing on 2017/9/12.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerAreaModel.h"

@interface PickerCityModel : NSObject

@property (nonatomic, strong) NSString                           *city;
@property (nonatomic, strong) NSMutableArray <PickerAreaModel *> *areas;

@end
