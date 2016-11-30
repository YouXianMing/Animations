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

@property (nonatomic)         NSInteger                           section;
@property (nonatomic)         CGFloat                             sectionHeaderHeight;
@property (nonatomic)         CGFloat                             sectionFooterHeight;
@property (nonatomic, strong) id                                  sectionData;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@end
