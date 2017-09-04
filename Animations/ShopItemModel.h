//
//  ShopItemModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ShopItemModel : NSObject

@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *itemId;
@property (nonatomic, strong) NSNumber *items_count;
@property (nonatomic, strong) NSNumber *order;
@property (nonatomic, strong) NSString *icon_url;
@property (nonatomic, strong) NSNumber *parent_id;
@property (nonatomic, strong) NSString *name;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

