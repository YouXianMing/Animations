//
//  TableGridView.h
//  GridTableView
//
//  Created by YouXianMing on 16/7/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "CellDataAdapter.h"
@class TableGridView;
@class TableGridViewCellClassType;

#pragma mark - TableGridViewDelegate

@protocol TableGridViewDelegate <NSObject>

/**
 *  TableGridView did selected event.
 *
 *  @param tableGridView 
 *  @param cell          CustomCell type's cell.
 */
- (void)tableGridView:(TableGridView *)tableGridView didSelectedCell:(CustomCell *)cell;

@end

#pragma mark - TableGridView Class

@interface TableGridView : UIView

/**
 *  TableGridView's delegate.
 */
@property (nonatomic, weak) id <TableGridViewDelegate> delegate;

/**
 *  Register the cells.
 */
@property (nonatomic, strong) NSArray <TableGridViewCellClassType *> *registerCells;

/**
 *  The cells data adapter.
 */
@property (nonatomic, strong) NSArray <CellDataAdapter *> *adapters;

/**
 *  Scroll enabled or not.
 */
@property (nonatomic) BOOL scrollEnabled;

/**
 *  Get the tableView's content size.
 *
 *  @return The tableView's content size.
 */
- (CGSize)contentSize;

/**
 *  Reset to the specified size.
 *
 *  @param size The specified size.
 */
- (void)resetToSize:(CGSize)size;

/**
 *  Reload data.
 */
- (void)reloadData;

@end

#pragma mark - TableGridViewCellClassType Class

@interface TableGridViewCellClassType : NSObject

@property (nonatomic)         Class      className;
@property (nonatomic, strong) NSString  *reuseIdentifier;

@end

NS_INLINE TableGridViewCellClassType *tableGridViewCellClassType(Class className, NSString  *reuseIdentifier) {
    
    TableGridViewCellClassType *type = [TableGridViewCellClassType new];
    type.className                   = className;
    type.reuseIdentifier             = reuseIdentifier;
    
    return type;
}

