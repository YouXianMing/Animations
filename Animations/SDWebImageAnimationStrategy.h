//
//  SDWebImageAnimationStrategy.h
//  Animations
//
//  Created by YouXianMing on 16/2/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDWebImageAnimationStrategy : NSObject

/**
 *  Image view.
 */
@property (nonatomic, weak) UIView  *imageView;

/**
 *  Start animation.
 */
- (void)startAnimation;

@end
