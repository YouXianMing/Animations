//
//  PickerViewDataAdapter.h
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/1.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerViewComponent.h"

@interface PickerViewDataAdapter : NSObject

@property (nonatomic, strong) NSArray <PickerViewComponent *> *components;
@property (nonatomic)         CGFloat                          rowHeight;

+ (instancetype)pickerViewDataAdapterWithComponents:(NSArray <PickerViewComponent *> *)components
                                          rowHeight:(CGFloat)rowHeight;

+ (instancetype)pickerViewDataAdapterWithComponentsBlock:(void (^)(NSMutableArray <PickerViewComponent *> *components))componentsBlock
                                               rowHeight:(CGFloat)rowHeight;

@end
