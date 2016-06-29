//
//  TapAnimationModel.m
//  Animations
//
//  Created by YouXianMing on 15/11/27.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "TapAnimationModel.h"

@implementation TapAnimationModel

+ (instancetype)modelWithName:(NSString *)name selected:(BOOL)selected {

    TapAnimationModel *model = [[[self class] alloc] init];
    
    model.name     = name;
    model.selected = selected;
    
    return model;
}

@end
