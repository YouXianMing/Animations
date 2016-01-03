//
//  NodeModelCell.h
//  NodeModel
//
//  Created by YouXianMing on 15/11/10.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NodeModelCell;

@protocol NodeModelCellDelegate <NSObject>

- (void)nodeModelCell:(NodeModelCell *)cell data:(id)data;

@end

static NSString *nodeCellReusedString = @"NodeModelCell";

@interface NodeModelCell : UITableViewCell

@property (nonatomic, weak) id <NodeModelCellDelegate> delegate;
@property (nonatomic, weak) NSIndexPath               *indexPath;
@property (nonatomic, weak) UIViewController          *viewController;
@property (nonatomic, weak) id                         data;

/**
 *  加载数据
 */
- (void)loadData;

@end
