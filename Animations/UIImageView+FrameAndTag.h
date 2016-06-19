//
//  UIImageView+FrameAndTag.h
//  SetRect
//
//  Created by YouXianMing on 16/6/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessViewTagProtocol.h"

@interface UIImageView (FrameAndTag)

/**
 *  设置图片以及tag值
 */
+ (instancetype)insertIntoView:(UIView *)view
                           tag:(NSInteger)tag
                    attachedTo:(id <AccessViewTagProtocol>)object
                    imageNamed:(NSString *)imageName
                    setupBlock:(ViewSetupBlock)block;

/**
 *  设置图片
 */
+ (instancetype)insertIntoView:(UIView *)view
                    imageNamed:(NSString *)imageName
                    setupBlock:(ViewSetupBlock)block;

@end
