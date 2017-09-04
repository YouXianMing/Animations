//
//  PickerViewComponent.m
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/1.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "PickerViewComponent.h"

@implementation PickerViewComponent

+ (instancetype)pickerViewComponentWithRows:(NSArray <PickerViewRow *> *)rows
                             componentWidth:(CGFloat)componentWidth {
    
    PickerViewComponent *component = [[[self class] alloc] init];
    component.rows                 = rows;
    component.componentWidth       = componentWidth;
    
    return component;
}

+ (instancetype)pickerViewComponentWithRowsBlock:(void (^)(NSMutableArray <PickerViewRow *> *rows))rowsBlock
                                  componentWidth:(CGFloat)componentWidth {
    
    NSMutableArray *rows = [NSMutableArray array];
    if (rowsBlock) {
        
        rowsBlock(rows);
    }
    
    PickerViewComponent *component = [[[self class] alloc] init];
    component.rows                 = [NSArray arrayWithArray:rows];
    component.componentWidth       = componentWidth;
    
    return component;
}

@end
