//
//  PickerViewDataAdapter.m
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/1.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "PickerViewDataAdapter.h"

@implementation PickerViewDataAdapter

+ (instancetype)pickerViewDataAdapterWithComponents:(NSArray <PickerViewComponent *> *)components
                                          rowHeight:(CGFloat)rowHeight {
    
    PickerViewDataAdapter *adpater = [[[self class] alloc] init];
    adpater.components             = components;
    adpater.rowHeight              = rowHeight;
    
    return adpater;
}

+ (instancetype)pickerViewDataAdapterWithComponentsBlock:(void (^)(NSMutableArray <PickerViewComponent *> *))componentsBlock
                                               rowHeight:(CGFloat)rowHeight {
    
    NSMutableArray *array = [NSMutableArray array];
    if (componentsBlock) {
        
        componentsBlock(array);
    }
    
    PickerViewDataAdapter *adpater = [[[self class] alloc] init];
    adpater.components             = [NSArray arrayWithArray:array];
    adpater.rowHeight              = rowHeight;
    
    return adpater;
}

@end
