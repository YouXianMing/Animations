//
//  RotateAnimationViewTypeProtocol.h
//  Animations
//
//  Created by YouXianMing on 15/12/3.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RotateAnimationViewTypeProtocol <NSObject>

/**
 *  Set client view.
 *
 *  @param clientView Client.
 */
- (void)setClientView:(UIView *)clientView;

/**
 *  Get client view.
 *
 *  @return client.
 */
- (UIView *)clientView;

/**
 *  Start animation.
 */
- (void)startAnimation;

/**
 *  Additional parameter.
 *
 *  @param param Parameter dictionary.
 */
- (void)additionalParameter:(NSDictionary *)param;

@end
