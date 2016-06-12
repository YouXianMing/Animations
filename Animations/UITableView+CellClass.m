//
//  UITableView+CellClass.m
//  Animations
//
//  Created by YouXianMing on 16/6/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UITableView+CellClass.h"

@implementation UITableView (CellClass)

- (void)registerCellsClass:(NSArray <NSString *> *)cellClasses {

    for (int i = 0; i < cellClasses.count; i++) {
        
        NSString *cellClassString = cellClasses[i];
        [self registerClass:NSClassFromString(cellClassString) forCellReuseIdentifier:cellClassString];
    }
}

@end
