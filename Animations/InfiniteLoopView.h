//
//  InfiniteLoopView.h
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfiniteLoopViewProtocol.h"
#import "InfiniteLoopCellClassProtocol.h"
#import "CustomInfiniteLoopCell.h"
@class InfiniteLoopView;

@protocol InfiniteLoopViewDelegate <NSObject>

@optional

/**
 *  Get the InfiniteLoopView's data.
 *
 *  @param infiniteLoopView InfiniteLoopView's object.
 *  @param data             data.
 *  @param index            Current index.
 *  @param cell             CustomInfiniteLoopCell type's cell.
 */
- (void)infiniteLoopView:(InfiniteLoopView *)infiniteLoopView
                    data:(id <InfiniteLoopViewProtocol>)data
           selectedIndex:(NSInteger)index
                    cell:(CustomInfiniteLoopCell *)cell;

/**
 *  Did scroll to get the current page.
 *
 *  @param infiniteLoopView InfiniteLoopView's object.
 *  @param index            Current index.
 */
- (void)infiniteLoopView:(InfiniteLoopView *)infiniteLoopView didScrollCurrentPage:(NSInteger)index;

@end

@interface InfiniteLoopView : UIView

/**
 *  InfiniteLoopView's delegate.
 */
@property (nonatomic, weak) id <InfiniteLoopViewDelegate> delegate;

/**
 *  Image model's array, you must set this value.
 */
@property (nonatomic, strong) NSArray <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol> *models;

/**
 *  Scroll time interval, default is 4s.
 */
@property (nonatomic) NSTimeInterval  scrollTimeInterval;

/**
 *  Scroll direction, default is horizontal.
 */
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

/**
 *  Stop the loop animation and let the image model's array equal nil.
 */
- (void)reset;

/**
 *  Before start the loop animation, you should run this method before.
 */
- (void)prepare;

/**
 *  Start the loop animation.
 */
- (void)startLoopAnimation;

/**
 *  Stop the loop animation.
 */
- (void)stopLoopAnimation;

/**
 *  Current page value.
 */
@property (nonatomic, readonly) NSInteger currentPage;

@end
