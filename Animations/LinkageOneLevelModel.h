//
//  LinkageOneLevelModel.h
//  SecondList
//
//  Created by YouXianMing on 2017/8/25.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkageTwoLevelModel.h"
#import "CellDataAdapter.h"
#import "CellHeaderFooterDataAdapter.h"

@interface LinkageOneLevelModel : NSObject

@property (nonatomic, strong) CellDataAdapter             *adapter;       // cell数据适配器
@property (nonatomic, strong) CellHeaderFooterDataAdapter *headerAdapter; // cellHeader数据适配器
@property (nonatomic)         BOOL selected;                              // 是否是选中状态

@property (nonatomic, strong) NSArray <LinkageTwoLevelModel *> *subModels;

@end
