//
//  PickerViewRow.m
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/1.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "PickerViewRow.h"

@implementation PickerViewRow

+ (instancetype)pickerViewRowWithViewClass:(Class)viewClass data:(id)data {
    
    PickerViewRow *row        = [[[self class] alloc] init];
    row.pickerCustomViewClass = viewClass;
    row.data                  = data;
    
    return row;
}

@end
