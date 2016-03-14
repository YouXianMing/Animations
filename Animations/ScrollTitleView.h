//
//  ScrollTitleView.h
//  Animations
//
//  Created by YouXianMing on 16/3/13.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollTitleView : UIView

/**
 *  Title
 */
@property (nonatomic, strong) NSString  *title;

/**
 *  The inputValue value is in range [0, 1].
 */
@property (nonatomic) CGFloat  inputValue;

/**
 *  Build sub view.
 */
- (void)buildSubViews;

@end
