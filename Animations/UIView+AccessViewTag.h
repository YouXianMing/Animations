//
//  UIView+AccessViewTag.h
//  Animations
//
//  Created by YouXianMing on 16/6/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessViewTagProtocol.h"

@interface UIView (AccessViewTag)

/**
 *  Get the view with specified tag from CustomViewController type's controller.
 *
 *  @param tag    View's tag.
 *  @param object AccessViewTagProtocol's object.
 *
 *  @return The view.
 */
+ (instancetype)viewWithTag:(NSInteger)tag from:(id <AccessViewTagProtocol>)object;

/**
 *  Set the view's tag.
 *
 *  @param tag    View's tag.
 *  @param object AccessViewTagProtocol's object.
 */
- (void)setTag:(NSInteger)tag attachedTo:(id <AccessViewTagProtocol>)object;

@end
