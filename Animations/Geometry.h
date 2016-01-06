//
//  Geometry.h
//  ZiPeiYi
//
//  Created by YouXianMing on 16/1/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Geometry : NSObject

/**
 *  Get the new size with the fixed width.
 *
 *  @param size  Old size.
 *  @param width The fixed width.
 *
 *  @return New size.
 */
+ (CGSize)resetFromSize:(CGSize)size withFixedWidth:(CGFloat)width;

/**
 *  Get the new size with the fixed height.
 *
 *  @param size   Old size.
 *  @param height The fixed width.
 *
 *  @return New size.
 */
+ (CGSize)resetFromSize:(CGSize)size withFixedHeight:(CGFloat)height;

@end

