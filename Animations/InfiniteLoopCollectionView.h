//
//  InfiniteLoopCollectionView.h
//  InfiniteLoopCollectionView
//
//  Created by YouXianMing on 2017/8/3.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataAdapter.h"
#import "BaseCustomCollectionCell.h"
@class InfiniteLoopCollectionView;

@protocol InfiniteLoopCollectionViewDelegate <NSObject>

@optional

- (void)infiniteLoopCollectionView:(InfiniteLoopCollectionView *)infiniteLoopCollectionView
                     selectedIndex:(NSInteger)index
                              cell:(BaseCustomCollectionCell *)cell;

- (void)infiniteLoopCollectionView:(InfiniteLoopCollectionView *)infiniteLoopCollectionView
              didScrollCurrentPage:(NSInteger)currentPage;

/**
 *  [Special] This method is related with the BaseCustomCollectionCell's delegate method 'customCollectionCell:event:'.
 */
- (void)infiniteLoopCollectionView:(InfiniteLoopCollectionView *)infiniteLoopCollectionView
                              cell:(BaseCustomCollectionCell *)cell
                             event:(id)event;

@end

@interface InfiniteLoopCollectionView : UIView

/**
 *  Scroll time interval, default is 8s.
 */
@property (nonatomic) NSTimeInterval  scrollTimeInterval;

/**
 *  Scroll direction, default is horizontal.
 */
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

/**
 *  The delegate.
 */
@property (nonatomic, weak) id <InfiniteLoopCollectionViewDelegate> delegate;

/**
 *  Register cells with collectionView.
 *
 *  @param configBlock The configBlock.
 */
- (void)registerCellsWithCollectionView:(void (^)(UICollectionView *collectionView))configBlock;

/**
 *  The cell data adapters.
 */
@property (nonatomic, strong) NSArray <CellDataAdapter *> *adapters;

/**
 *  Stop the loop animation and let the image model's array equal nil.
 */
- (void)reset;

/**
 *  Before start the loop animation, you should run this method before.
 */
- (void)loadData;

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

/**
 *  Adjust when freeze.
 */
- (void)adjustWhenFreeze;

#pragma mark - Constructor.

+ (instancetype)infiniteLoopCollectionViewWithFrame:(CGRect)frame
                                 scrollTimeInterval:(NSTimeInterval)scrollTimeInterval
                                    scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                                           delegate:(id <InfiniteLoopCollectionViewDelegate>)delegate
                                      registerCells:(void (^)(UICollectionView *collectionView))configBlock;

- (void)startLoopWithAdapters:(NSArray <CellDataAdapter *> *)adapters runTimerLoopEvent:(BOOL)timerEvent;

@end
