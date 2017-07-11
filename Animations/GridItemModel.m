//
//  GridItemModel.m
//  Animations
//
//  Created by YouXianMing on 2017/7/11.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "GridItemModel.h"

@implementation GridItemModel

+ (instancetype)gridItemModelWithTitle:(NSString *)title icon:(NSString *)icon {
    
    GridItemModel *model = [[self class] new];
    model.title          = title;
    model.icon           = icon;
    
    return model;
}

@end
