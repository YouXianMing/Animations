//
//  TableViewSectionItem.h
//  TechCode
//
//  Created by YouXianMing on 2016/11/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomCell.h"

@interface TableViewSectionItem : NSObject

/**
 The section number.
 */
@property (nonatomic) NSInteger  section;

/**
 The adapters's array.
 */
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

/**
 Section's header height.
 */
@property (nonatomic) CGFloat  sectionHeaderHeight;

/**
 HeaderView's identifier.
 */
@property (nonatomic, strong) NSString  *headerViewIdentifier;

/**
 Section's footer height.
 */
@property (nonatomic) CGFloat  sectionFooterHeight;

/**
 FooterView's identifier.
 */
@property (nonatomic, strong) NSString  *footerViewIdentifier;

/**
 The section header data.
 */
@property (nonatomic, strong) id  sectionHeaderData;

/**
 The section footer data.
 */
@property (nonatomic, strong) id  sectionFooterData;

@end
