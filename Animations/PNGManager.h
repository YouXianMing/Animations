//
//  PNGManager.h
//  PNGIconsCompressTool
//
//  Created by YouXianMing on 2017/11/7.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PNG.h"

@interface PNGManager : NSObject

/**
 根据给定的图片以及PNG图片格式的数组批量生成@1x,@2x,@3x的图片
 
 @param sourceImage 原始高清图片
 @param pngsBlock 配置PNG图片格式的数组的block
 */
+ (void)createPNGsWithSourceImage:(UIImage *)sourceImage pngsBlock:(void (^)(NSMutableArray <PNG *> *pngs))pngsBlock;

@end
