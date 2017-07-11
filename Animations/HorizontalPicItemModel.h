//
//  HorizontalPicItemModel.h
//  Animations
//
//  Created by YouXianMing on 2017/7/11.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HorizontalPicItemModel : NSObject

@property (nonatomic, strong) UIImage *iconImage;

+ (instancetype)horizontalPicItemModelWithIconImage:(UIImage *)image;

@end
