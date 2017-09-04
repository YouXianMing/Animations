//
//  CategoryModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ShopItemModel.h"

@interface CategoryModel : NSObject

@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *icon_url;
@property (nonatomic, strong) NSNumber *order;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray <ShopItemModel *> *subcategories;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

