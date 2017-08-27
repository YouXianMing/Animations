//
//  CustomLevelLinkageCell.h
//  SecondList
//
//  Created by YouXianMing on 2017/8/26.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CustomCell.h"
#import "LinkageOneLevelModel.h"
#import "LinkageTwoLevelModel.h"

@interface CustomLevelLinkageCell : CustomCell

/**
 级联model,如果是左边tableView,则为LinkageOneLevelModel,如果为右边tableView,则为LinkageTwoLevelModel
 */
@property (nonatomic, weak) id levelModel;

/**
 更新到选中状态
 */
- (void)updateToSelectedStateAnimated:(BOOL)animated;

/**
 更新到普通状态
 */
- (void)updateToNormalStateAnimated:(BOOL)animated;;

@end
