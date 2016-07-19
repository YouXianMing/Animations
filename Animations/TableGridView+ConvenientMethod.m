//
//  TableGridView+ConvenientMethod.m
//  GridTableView
//
//  Created by YouXianMing on 16/7/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "TableGridView+ConvenientMethod.h"

@implementation TableGridView (ConvenientMethod)

+ (instancetype)tableGridViewWithFixedWidth:(CGFloat)width
                              registerCells:(NSArray <TableGridViewCellClassType *> *)registerCells
                                   adapters:(NSArray <CellDataAdapter *> *)adapters
                                   delegate:(id <TableGridViewDelegate>)delegate {

    NSParameterAssert(registerCells);
    NSParameterAssert(adapters);
    
    TableGridView *tableGridView = [[TableGridView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    tableGridView.registerCells  = registerCells;
    tableGridView.adapters       = adapters;
    tableGridView.delegate       = delegate;
    [tableGridView reloadData];
    [tableGridView resetToSize:[tableGridView contentSize]];
    
    return tableGridView;
}

@end
