//
//  NSObject+ItemStyle.h
//  Animations
//
//  Created by YouXianMing on 2017/7/27.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemStyleInterface.h"

@interface NSObject (ItemStyle)

/**
 元素样式
 */
@property (nonatomic, strong) id <ItemStyleInterface> itemStyle;

@end
