//
//  PickerViewRow.h
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/1.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerCustomView.h"

@interface PickerViewRow : NSObject

@property (nonatomic) Class      pickerCustomViewClass;
@property (nonatomic, strong) id data;

+ (instancetype)pickerViewRowWithViewClass:(Class)viewClass data:(id)data;

@end
