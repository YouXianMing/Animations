//
//  HorizontalPicItemModel.m
//  Animations
//
//  Created by YouXianMing on 2017/7/11.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "HorizontalPicItemModel.h"

@implementation HorizontalPicItemModel

+ (instancetype)horizontalPicItemModelWithIconImage:(UIImage *)image {
    
    HorizontalPicItemModel *model = [[self class] new];
    model.iconImage               = image;
    
    return model;
}

@end
