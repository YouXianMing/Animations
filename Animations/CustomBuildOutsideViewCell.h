//
//  CustomBuildOutsideViewCell.h
//  Animations
//
//  Created by YouXianMing on 16/9/14.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomCell.h"
@class CustomBuildOutsideViewCell;

@protocol CustomBuildOutsideViewCellDelegate <NSObject>

@optional

/**
 *  You should use this method to add subview.
 *
 *  @param cell           The CustomBuildOutsideViewCell type cell.
 *  @param cellIdentifier The CustomBuildOutsideViewCell's identifier.
 */
- (void)customBuildOutsideViewCell:(CustomBuildOutsideViewCell *)cell cellIdentifier:(NSString *)cellIdentifier;

@end

/**
 *  [IMPORTANT] Not reusable, and loadContent method is the last step.
 */
@interface CustomBuildOutsideViewCell : CustomCell

/**
 *  The CustomBuildOutsideViewCell's delegate.
 */
@property (nonatomic, weak) id <CustomBuildOutsideViewCellDelegate> buildOutsideViewCellDelegate;

@end
