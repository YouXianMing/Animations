//
//  PictureModel.h
//  SDWebImageLoadImageAnimation
//
//  Created by YouXianMing on 15/4/30.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject

/**
 *  图片地址字符串
 */
@property (nonatomic, strong) NSString *pictureUrlString;

/**
 *  图片地址
 */
@property (nonatomic, strong) NSURL     *pictureUrl;

/**
 *  便利构造器
 *
 *  @param url          图片地址
 *  @param haveAnimated 是否执行过动画
 *
 *  @return 实例对象
 */
+ (instancetype)pictureModelWithPictureUrl:(NSURL *)url haveAnimated:(BOOL)haveAnimated;

@end
