//
//  iCarouselAbsItemView.h
//  iCarouselExample
//
//  Created by YouXianMing on 2016/12/28.
//  Copyright © 2016年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarouselAdapter.h"

@interface iCarouselAbsItemView : UIView

@property (nonatomic, weak) iCarouselAdapter *adpter;
@property (nonatomic, weak) id                data;
@property (nonatomic)       NSInteger         index;

/**
 Offset X.
 
 @param x The x.
 */
- (void)offsetX:(CGFloat)x;

#pragma mark - Override by subClass.

/**
 The item height.
 */
@property (class, nonatomic, readonly) CGFloat itemHeight;

/**
 The item width.
 */
@property (class, nonatomic, readonly) CGFloat itemWidth;

/**
 Base setup.
 */
- (void)setup;

/**
 Build subViews.
 */
- (void)buildSubViews;

/**
 Load content.
 */
- (void)loadContent;

@end
