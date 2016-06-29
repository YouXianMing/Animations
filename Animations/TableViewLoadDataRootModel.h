//
//  TableViewLoadDataRootModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MetaModel.h"
#import "DataModel.h"

@interface TableViewLoadDataRootModel : NSObject

@property (nonatomic, strong) MetaModel *meta;
@property (nonatomic, strong) NSMutableArray <DataModel *> *data;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

