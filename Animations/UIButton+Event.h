//
//  UIButton+Event.h
//  RecordMusic
//
//  Created by YouXianMing on 16/7/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Button's event block.
 *
 *  @param button Button.
 */
typedef void (^buttonEvent_t)(UIButton *button);

@interface UIButton (Event)

/**
 *  Button's block event method.
 *
 *  @param block Button event block.
 */
- (void)blockEvent:(buttonEvent_t)block;

#pragma mark - Constructor

/**
 *  Constructor to create button.
 *
 *  @param frame       The button's frame.
 *  @param configBlock To config the button.
 *  @param eventBlock  The event block.
 *
 *  @return UIButton.
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame configBlock:(void (^)(UIButton *button))configBlock eventBlock:(buttonEvent_t)eventBlock;

@end
