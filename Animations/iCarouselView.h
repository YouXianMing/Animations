//
//  iCarouselView.h
//  iCarouselExample
//
//  Created by YouXianMing on 2016/12/28.
//  Copyright © 2016年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "iCarouselAbsItemView.h"
#import "iCarouselAdapter.h"
@class iCarouselView;

@protocol iCarouselViewDelegate <NSObject>

@optional

- (void)iCarouselView:(iCarouselView *)iCarouselView didSelectCarouselAbsItemView:(iCarouselAbsItemView *)itemView adapter:(iCarouselAdapter *)adapter;

@end

@interface iCarouselView : UIView

/**
 iCarousel.
 */
@property (nonatomic, strong, readonly) iCarousel *carousel;

/**
 iCarouselView's delegate.
 */
@property (nonatomic, weak) id <iCarouselViewDelegate> delegate;

/**
 Data source.
 */
@property (nonatomic, strong) NSArray <iCarouselAdapter *> *adapters;

/**
 Reload the data.
 */
- (void)reloadData;

/**
 Config the iCarousel, override by subclass.

 @param iCarousel The iCarousel object.
 */
- (void)configTheiCarousel:(iCarousel *)iCarousel;

/**
 Create reusing view, override by subclass.

 @param index The view index.
 @param adapter The adapter.
 @param view  The kindof iCarouselAbsItemView.
 @return The kindof iCarouselAbsItemView.
 */
- (__kindof iCarouselAbsItemView *)viewForItemAtIndex:(NSInteger)index adapter:(iCarouselAdapter *)adapter reusingView:(__kindof iCarouselAbsItemView *)view;

/**
 Value for options, override by subclass.

 @param option The options.
 @param value The values.
 @return The set value.
 */
- (CGFloat)valueForOption:(iCarouselOption)option withDefault:(CGFloat)value;

@end
