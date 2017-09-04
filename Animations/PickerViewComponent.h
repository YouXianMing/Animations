//
//  PickerViewComponent.h
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/1.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PickerViewRow.h"

@interface PickerViewComponent : NSObject

@property (nonatomic, strong) NSArray <PickerViewRow *> *rows;
@property (nonatomic)         CGFloat                    componentWidth;

+ (instancetype)pickerViewComponentWithRows:(NSArray <PickerViewRow *> *)rows
                             componentWidth:(CGFloat)componentWidth;

+ (instancetype)pickerViewComponentWithRowsBlock:(void (^)(NSMutableArray <PickerViewRow *> *rows))rowsBlock
                                  componentWidth:(CGFloat)componentWidth;

@end
