//
//  UITableView+CellClass.h
//  Animations
//
//  Created by YouXianMing on 16/6/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CellClass)

/**
 *  Register cells class, eg. If cellClasses = @[@"CustomCell", @"LineCell"]; it means [self registerClass:NSClassFromString(CustomCell") forCellReuseIdentifier:@"CustomCell"] and [self registerClass:NSClassFromString(@"LineCell") @"LineCell"].
 *
 *  @param cellClasses Cells class String array.
 */
- (void)registerCellsClass:(NSArray <NSString *> *)cellClasses;

@end
