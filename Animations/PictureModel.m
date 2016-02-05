//
//  PictureModel.m
//  SDWebImageLoadImageAnimation
//
//  Created by YouXianMing on 15/4/30.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "PictureModel.h"

@implementation PictureModel

+ (instancetype)pictureModelWithPictureUrl:(NSURL *)url haveAnimated:(BOOL)haveAnimated {
    
    PictureModel *model = [PictureModel new];
    model.pictureUrl    = url;
    
    return model;
}

@end
