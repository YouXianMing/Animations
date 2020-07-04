//
//  CollectionSectionData.h
//  AjMall
//
//  Created by YouXianMing on 2018/8/30.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellDataAdapter.h"
#import "CollectionSectionHeaderData.h"
#import "CollectionSectionFooterData.h"
#import "WaterfallCollectionSectionHeaderData.h"
#import "WaterfallCollectionSectionFooterData.h"

@interface CollectionSectionData : NSObject

/**
 区域内的最小元素间距
 */
@property (nonatomic) CGFloat minimumInteritemSpacing;

/**
 区域内的最小行间距
 */
@property (nonatomic) CGFloat minimumLineSpacing;

/**
 区域内的边距
 */
@property (nonatomic) UIEdgeInsets sectionInsets;

/**
 SectionHeader数据
 */
@property (nonatomic, strong) CollectionSectionHeaderData *headerData;

/**
 中间的cell
 */
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

/**
 SectionFooter数据
 */
@property (nonatomic, strong) CollectionSectionFooterData *footerData;

/**
 携带的数据
 */
@property (nonatomic, strong) id data;

/**
 标记
 */
@property (nonatomic, strong) NSString *mark;

#pragma mark - 瀑布流相关参数

/**
 SectionHeader数据
 */
@property (nonatomic, strong) WaterfallCollectionSectionHeaderData *waterfallHeaderData;

/**
 SectionHeader数据
 */
@property (nonatomic, strong) WaterfallCollectionSectionFooterData *waterfallFooterData;

/**
 layout为CHTCollectionViewWaterfallLayout时专用,默认值为1(瀑布流条数)
 */
@property (nonatomic) NSInteger columnCountForSection;

#pragma mark - 实用方法

/**
 从SectionData的数组中查找指定mark的CollectionSectionData

 @param datasArray CollectionSectionData的数组
 @param mark CollectionSectionData的mark值
 @return CollectionSectionData数据或者nil
 */
+ (CollectionSectionData *)findSectionDataFromSectionDatasArray:(NSArray <CollectionSectionData *> *)datasArray withMark:(NSString *)mark;

@end
