//
//  InfiniteLoopViewBuilder.h
//  InfiniteLoopView
//
//  Created by YouXianMing on 16/5/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNodeStateView.h"
#import "UIView+SetRect.h"
#import "InfiniteLoopViewProtocol.h"
#import "InfiniteLoopCellClassProtocol.h"
#import "CustomInfiniteLoopCell.h"
@class InfiniteLoopViewBuilder;

@protocol InfiniteLoopViewBuilderEventDelegate <NSObject>

@optional

/**
 *  Get the InfiniteLoopViewBuilder's data.
 *
 *  @param infiniteLoopViewBuilder  InfiniteLoopViewBuilder's object.
 *  @param data                     data.
 *  @param index                    Current index.
 */
- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
                           data:(id <InfiniteLoopViewProtocol>)data
                  selectedIndex:(NSInteger)index
                           cell:(CustomInfiniteLoopCell *)cell;

/**
 *  Did scroll to get the current page.
 *
 *  @param InfiniteLoopViewBuilder InfiniteLoopViewBuilder's object.
 *  @param index                   Current index.
 */
- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
           didScrollCurrentPage:(NSInteger)index;

@end

typedef enum : NSUInteger {
    
    kNodeViewTop,
    kNodeViewTopLeft,
    kNodeViewTopRight,
    
    kNodeViewBottom,
    kNodeViewBottomLeft,
    kNodeViewBottomRight,
    
    kNodeViewLeft,
    kNodeViewLeftTop,
    kNodeViewLeftBottom,
    
    kNodeViewRight,
    kNodeViewRightTop,
    kNodeViewRightBottom,
    
} ENodeViewShowPosition;

@interface InfiniteLoopViewBuilder : UIView

/**
 *  InfiniteLoopViewBuilder's delegate.
 */
@property (nonatomic, weak) id <InfiniteLoopViewBuilderEventDelegate> delegate;

/**
 *  The contentView that you can add view to it.
 */
@property (nonatomic, strong, readonly) UIView  *contentView;

/**
 *  CustomNodeStateView's template.
 */
@property (nonatomic, strong) CustomNodeStateView  *nodeViewTemplate;

/**
 *  NodeStateViews's edgeInsets.
 */
@property (nonatomic) UIEdgeInsets  edgeInsets;

/**
 *  Image model's array, you must set this value.
 */
@property (nonatomic, strong) NSArray <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol>  *models;

/**
 *  Set the NodeView's size, default is (10, 10).
 */
@property (nonatomic) CGSize  sampleNodeViewSize;

/**
 *  The CustomNodeStateViews show position, default is kNodeViewBottom.
 */
@property (nonatomic) ENodeViewShowPosition  position;

/**
 *  Scroll time interval, default is 4s.
 */
@property (nonatomic) NSTimeInterval  scrollTimeInterval;

/**
 *  Scroll direction, default is horizontal.
 */
@property (nonatomic) UICollectionViewScrollDirection  scrollDirection;

/**
 *  Start the loop.
 *
 *  @param animated Animated or not.
 */
- (void)startLoopAnimated:(BOOL)animated;

@end
