//
//  CellHeaderFooterDataAdapter.h
//  SecondList
//
//  Created by YouXianMing on 2017/8/25.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellHeaderFooterDataAdapter : NSObject

/**
 *  Cell header's reused identifier.
 */
@property (nonatomic, strong) NSString *cellHeaderReuseIdentifier;

/**
 *  Data, can be nil.
 */
@property (nonatomic, strong) id data;

/**
 *  Cell header's height, only used for UITableView's cell.
 */
@property (nonatomic) CGFloat headerHeight;

@property (nonatomic) NSInteger section;

@end
