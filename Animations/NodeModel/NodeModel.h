//
//  NodeModel.h
//  NodeModel
//
//  Created by YouXianMing on 15/11/10.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyInfomation.h"

static NSString *stringType = @"NSString";
static NSString *numberType = @"NSNumber";
static NSString *nullType   = @"NSNull";

@interface NodeModel : NSObject

/**
 *  列表名字
 */
@property (nonatomic, strong) NSString *listType;

/**
 *  model的名字(在listType的基础上追加了Model字符串)
 */
@property (nonatomic, strong) NSString *modelName;

/**
 *  当前树形结构级别
 */
@property (nonatomic) NSInteger level;

/**
 *  普通的属性
 */
@property (nonatomic, strong) NSMutableDictionary *normalProperties;

/**
 *  字典类型元素
 */
@property (nonatomic, strong) NSMutableDictionary <NSString *, NodeModel *> *dictionaryTypeModelList;

/**
 *  数组类型元素
 */
@property (nonatomic, strong) NSMutableDictionary <NSString *, NodeModel *> *arrayTypeModelList;

/**
 *  便利构造器
 *
 *  @param dictionary 数据字典
 *  @param name       model名字
 *  @param level      当前树形结构级别
 *
 *  @return NodeModel对象
 */
+ (instancetype)nodeModelWithDictionary:(NSDictionary *)dictionary
                              modelName:(NSString *)name
                                  level:(NSInteger)level;

/**
 *  所有的property
 */
@property (nonatomic, strong, readonly) NSMutableArray <PropertyInfomation *>  *properties;

/**
 *  所有子孙节点
 *
 *  @return 数组
 */
- (NSArray *)allSubNodes;

@end
