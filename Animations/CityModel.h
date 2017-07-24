//
//  CityModel.h
//  TreeTableView
//
//  Created by YouXianMing on 2017/7/23.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property (nonatomic, strong) NSString                      *text;
@property (nonatomic)         NSInteger                      level;
@property (nonatomic, strong) NSMutableArray <CityModel *>  *submodels;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 设定展开还是缩放 [ extend为NO时,返回空的数组,为YES时,返回当前级别的submodels ]
 */
@property (nonatomic) BOOL extend;

/**
 通过递归的方法获取所有的子model [ 每次调用都会重新获取 ]
 */
@property (nonatomic, strong, readonly) NSMutableArray <CityModel *>  *allSubmodels;
@property (nonatomic, readonly)         NSInteger                      submodelsCount;

@end
