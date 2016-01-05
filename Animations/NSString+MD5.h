//
//  NSString+MD5.h
//  Animations
//
//  Created by YouXianMing on 16/1/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

/**
 *  Get lower MD5 string.
 *
 *  @return Lower MD5 string.
 */
- (NSString *)lowerMD532BitString;

/**
 *  Get upper MD5 string.
 *
 *  @return Upper MD5 string.
 */
- (NSString *)upperMD532BitString;

@end
