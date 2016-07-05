//
//  CustomInfiniteLoopCell.h
//  InfiniteLoopView
//
//  Created by XianMing You on 16/7/5.
//  Copyright © 2016年 XianMing You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfiniteLoopViewProtocol.h"

@interface CustomInfiniteLoopCell : UICollectionViewCell

/**
 *  Data model.
 */
@property (nonatomic, weak) id <InfiniteLoopViewProtocol>  dataModel;

/**
 *  Index path.
 */
@property (nonatomic, weak) NSIndexPath *indexPath;

/**
 *  Setup the UICollectionViewCell.
 */
- (void)setupCollectionViewCell;

/**
 *  Build the subView.
 */
- (void)buildSubView;

/**
 *  Load the data.
 */
- (void)loadContent;

/**
 *  Will display.
 */
- (void)willDisplay;

/**
 *  Did end display.
 */
- (void)didEndDisplay;

@end
