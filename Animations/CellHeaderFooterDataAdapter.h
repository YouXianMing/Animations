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
 *  Cell header or footer's reused identifier.
 */
@property (nonatomic, copy) NSString *reuseIdentifier;

/**
 *  Data, can be nil.
 */
@property (nonatomic, strong) id data;

/**
 *  Cell header or footer's height, only used for UITableView's cell.
 */
@property (nonatomic) CGFloat height;

/**
 *  Section value.
 */
@property (nonatomic) NSInteger section;

/**
 *  CellHeader or CellFooter's type (The same header or footer, but maybe have different types).
 */
@property (nonatomic) NSInteger type;

/**
 *  Constructor.
 *
 *  @param reuseIdentifier Cell header or footer's reused identifier.
 *  @param data Data, can be nil.
 *  @param height Cell header or footer's height, only used for UITableView's cell.
 *  @param type CellHeader or CellFooter's type (The same header or footer, but maybe have different types).
 *
 *  @return CellHeaderFooterDataAdapter
 */
+ (instancetype)cellHeaderFooterDataAdapterWithReuseIdentifier:(NSString *)reuseIdentifier data:(id)data height:(CGFloat)height type:(NSInteger)type;

@end
