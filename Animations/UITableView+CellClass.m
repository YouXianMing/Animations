//
//  UITableView+CellClass.m
//  Animations
//
//  Created by YouXianMing on 16/6/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "UITableView+CellClass.h"
#import "CellDataAdapter.h"
#import "CustomCell.h"

@implementation UITableView (CellClass)

- (void)registerCellsClass:(NSArray <CellClassType *> *)cellClasses {

    for (int i = 0; i < cellClasses.count; i++) {
        
        CellClassType *cellClass = cellClasses[i];
        [self registerClass:NSClassFromString(cellClass.classString) forCellReuseIdentifier:cellClass.reuseIdentifier];
    }
}

- (CustomCell *)dequeueAndLoadContentReusableCellFromAdapter:(CellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath {

    CustomCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    [cell setWeakReferenceWithCellDataAdapter:adapter data:adapter.data indexPath:indexPath tableView:self];
    [cell loadContent];
    
    return cell;
}

- (CustomCell *)dequeueAndLoadContentReusableCellFromAdapter:(CellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath
                                                  controller:(UIViewController *)controller {

    CustomCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.controller  = controller;
    [cell setWeakReferenceWithCellDataAdapter:adapter data:adapter.data indexPath:indexPath tableView:self];
    [cell loadContent];
    
    return cell;
}

@end

@implementation CellClassType

+ (instancetype)cellClassTypeWithClassString:(NSString *)classString reuseIdentifier:(NSString *)reuseIdentifier {
    
    NSParameterAssert(NSClassFromString(classString));
    
    CellClassType *type  = [[[self class] alloc] init];
    type.classString     = classString;
    type.reuseIdentifier = reuseIdentifier;
    
    return type;
}

+ (instancetype)cellClassTypeWithClassString:(NSString *)classString {

    NSParameterAssert(NSClassFromString(classString));
    
    CellClassType *type  = [[[self class] alloc] init];
    type.classString     = classString;
    type.reuseIdentifier = classString;
    
    return type;
}

@end