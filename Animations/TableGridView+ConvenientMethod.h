//
//  TableGridView+ConvenientMethod.h
//  GridTableView
//
//  Created by YouXianMing on 16/7/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TableGridView.h"

@interface TableGridView (ConvenientMethod)

/**
 *  Create TableGridView.
 *
 *  @param width         The fixed width.
 *  @param registerCells Register cells.
 *  @param adapters      Data adapters.
 *  @param delegate      The TableGridView's delegate.
 *
 *  @return TableGridView's object.
 */
+ (instancetype)tableGridViewWithFixedWidth:(CGFloat)width
                              registerCells:(NSArray <TableGridViewCellClassType *> *)registerCells
                                   adapters:(NSArray <CellDataAdapter *> *)adapters
                                   delegate:(id <TableGridViewDelegate>)delegate;

@end
