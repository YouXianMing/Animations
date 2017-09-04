//
//  CustomPickerViewControllerUserDefaults.m
//  Animations
//
//  Created by YouXianMing on 2017/9/4.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "CustomPickerViewControllerUserDefaults.h"

static NSString *_key_selectedRowInFirstComponent  = @"selectedRowInFirstComponent";
static NSString *_key_selectedRowInSecondComponent = @"selectedRowInSecondComponent";

@implementation CustomPickerViewControllerUserDefaults

+ (NSInteger)selectedRowInFirstComponent {
    
    return [CustomPickerViewControllerUserDefaults integerForKey:_key_selectedRowInFirstComponent];
}

+ (void)setSelectedRowInFirstComponent:(NSInteger)selectedRowInFirstComponent {
    
    [CustomPickerViewControllerUserDefaults setInteger:selectedRowInFirstComponent forKey:_key_selectedRowInFirstComponent];
}

+ (NSInteger)selectedRowInSecondComponent {
    
    return [CustomPickerViewControllerUserDefaults integerForKey:_key_selectedRowInSecondComponent];
}

+ (void)setSelectedRowInSecondComponent:(NSInteger)selectedRowInSecondComponent {
    
    [CustomPickerViewControllerUserDefaults setInteger:selectedRowInSecondComponent forKey:_key_selectedRowInSecondComponent];
}

@end
