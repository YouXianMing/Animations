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

+ (void)createPNGsWithSourceImage:(UIImage *)sourceImage pngsBlock:(void (^)(NSMutableArray <PNG *> *pngs))pngsBlock;

@end
