//
//  UIView+FrameAndTag.h
//  SetRect
//
//  Created by YouXianMing on 16/6/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessViewTagProtocol.h"

@interface UIView (FrameAndTag) <AccessViewTagProtocol>

#pragma mark - Set tags.

/**
 *  Support AccessViewTagProtocol.
 */
- (void)supportAccessViewTagProtocol;

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

#pragma mark - Init frames.

/**
 *  设置尺寸以及设置tag值
 */
+ (instancetype)viewWithFrame:(CGRect)frame insertIntoView:(UIView *)view tag:(NSInteger)tag
                   attachedTo:(id <AccessViewTagProtocol>)object setupBlock:(ViewSetupBlock)block;

/**
 *  设置尺寸
 */
+ (instancetype)viewWithFrame:(CGRect)frame insertIntoView:(UIView *)view setupBlock:(ViewSetupBlock)block;

#pragma mark - Init line view.

/**
 *  水平线条
 */
+ (instancetype)lineViewInsertIntoView:(UIView *)view positionY:(CGFloat)positionY thick:(CGFloat)thick
                               leftGap:(CGFloat)leftGap rightGap:(CGFloat)rightGap color:(UIColor *)color;

/**
 *  垂直线条
 */
+ (instancetype)lineViewInsertIntoView:(UIView *)view positionX:(CGFloat)positionX thick:(CGFloat)thick
                                topGap:(CGFloat)topGap bottomGap:(CGFloat)bottomGap color:(UIColor *)color;

@end

NS_INLINE id viewFrom(id <AccessViewTagProtocol> object, NSInteger tag) {
    
    return [UIView viewWithTag:tag from:object];
}

